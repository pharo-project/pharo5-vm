image segment in/out
objectsReachableFromRoots: arrayOfRoots
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Answer an Array of all the objects only reachable from the argument, an Array of root objects,
	 starting with arrayOfRoots.  If there is no space, answer a SmallInteger whose value is the
	 number of slots required.  This is used to collect the objects to include in an image segment
	 on Spur, separate from creating the segment, hence simplifying the implementation.
	 Thanks to Igor Stasenko for this idea."

	| freeChunk ptr start limit count oop objOop |
	<var: #freeChunk type: #usqInt> "& hence start & ptr are too; limit is also because of addressAfter:"
	<inline: #never>
	self assert: (self isArray: arrayOfRoots).
	"Mark all objects except those only reachable from the arrayOfRoots by marking
	 each object in arrayOfRoots and then marking all reachable objects (from the
	 system roots).  This leaves unmarked only objects reachable from the arrayOfRoots.
	 N.B. A side-effect of the marking is that all forwarders in arrayOfRoots will be followed."
 	self assert: self allObjectsUnmarked.
	self markObjectsIn: arrayOfRoots.
	self markObjects: false.

	"After the mark phase all unreachable weak slots will have been nilled
	 and all active ephemerons fired."
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).
	self assert: self noUnscannedEphemerons.

	"Use the largest free chunk to answer the result."
	freeChunk := self allocateLargestFreeChunk. "N.B. Does /not/ update totalFreeOldSpace"
	totalFreeOldSpace := totalFreeOldSpace - (self bytesInObject: freeChunk). "but must update so that growth in the markStack does not cause assert fails."
	ptr := start := freeChunk + self baseHeaderSize.
	limit := self addressAfter: freeChunk.
	count := 0.

	"First put the arrayOfRoots; order is important."
	count := count + 1.
	ptr < limit ifTrue:
		[self longAt: ptr put: arrayOfRoots.
		 ptr := ptr + self bytesPerOop].

	"Now collect the roots and the transitive closure of unmarked objects from them."
	0 to: (self numSlotsOf: arrayOfRoots) - 1 do:
		[:rx|
		 oop := self fetchPointer: rx ofObject: arrayOfRoots.
		 (self isNonImmediate: oop) ifTrue:
			[self deny: (self isForwarded: oop).
			 self noCheckPush: oop onObjStack: markStack.

			 "Collect the unmarked objects reachable from this root."
			 [self isEmptyObjStack: markStack] whileFalse:
				[objOop := self popObjStack: markStack.
				 count := count + 1.
				 ptr < limit ifTrue:
					[self longAt: ptr put: objOop.
					 ptr := ptr + self bytesPerOop].
				 oop := self fetchClassOfNonImm: objOop.
				 (self isMarked: oop) ifFalse:
					[self setIsMarkedOf: oop to: true.
					 self noCheckPush: oop onObjStack: markStack].
				 ((self isContextNonImm: objOop)
				  and: [coInterpreter isStillMarriedContext: objOop]) "widow now, before the loop"
					ifTrue:
						[0 to: (coInterpreter numSlotsOfMarriedContext: objOop) - 1 do:
							[:i|
							 oop := coInterpreter fetchPointer: i ofMarriedContext: objOop.
							 ((self isImmediate: oop)
							  or: [self isMarked: oop]) ifFalse:
								[self setIsMarkedOf: oop to: true.
								 self noCheckPush: oop onObjStack: markStack]]]
					ifFalse:
						[0 to: (self numPointerSlotsOf: objOop) - 1 do:
							[:i|
							 oop := self fetchPointer: i ofObject: objOop.
							 ((self isImmediate: oop)
							  or: [self isMarked: oop]) ifFalse:
								[self setIsMarkedOf: oop to: true.
								 self noCheckPush: oop onObjStack: markStack]]]]]].

	self unmarkAllObjects.

	"Now try and allocate the result"
	(count > (ptr - start / self bytesPerOop) "not enough room"
	 or: [limit ~= ptr and: [limit - ptr <= self allocationUnit]]) ifTrue: "can't split a single word"
		[self freeObject: freeChunk.
		 self checkFreeSpace: GCModeImageSegment.
		 ^self integerObjectOf: count].
	"There's room; set the format, & classIndex and shorten."
	self setFormatOf: freeChunk to: self arrayFormat.
	self setClassIndexOf: freeChunk to: ClassArrayCompactIndex.
	self shorten: freeChunk toIndexableSize: count.
	(self isForwarded: freeChunk) ifTrue:
		[freeChunk := self followForwarded: freeChunk].
	self possibleRootStoreInto: freeChunk.
	self checkFreeSpace: GCModeImageSegment.
	self runLeakCheckerFor: GCModeImageSegment.
	^freeChunk