debug support
checkHeapIntegrity: excludeUnmarkedNewSpaceObjs classIndicesShouldBeValid: classIndicesShouldBeValid
	"Perform an integrity/leak check using the heapMap.  Assume clearLeakMapAndMapAccessibleObjects
	 has set a bit at each (non-free) object's header.  Scan all objects in the heap checking that every
	 pointer points to a header.  Scan the rememberedSet, remapBuffer and extraRootTable checking
	 that every entry is a pointer to a header. Check that the number of roots is correct and that all
	 rememberedSet entries have their isRemembered: flag set.  Answer if all checks pass."
	| ok numRememberedObjectsInHeap |
	<inline: false>
	ok := true.
	numRememberedObjectsInHeap := 0.
	0 to: self numFreeLists - 1 do:
		[:i|
		(freeLists at: i) ~= 0 ifTrue:
			[(heapMap heapMapAtWord: (self pointerForOop: (freeLists at: i))) ~= 0 ifTrue:
				[coInterpreter print: 'leak in free list '; printNum: i; print: ' to non-free '; printHex: (freeLists at: i); cr.
				 self eek.
				 ok := false]]].

	"Excuse the duplication but performance is at a premium and we avoid
	 some tests by splitting the newSpace and oldSpace enumerations."
	self allNewSpaceEntitiesDo:
		[:obj| | fieldOop classIndex classOop |
		(self isFreeObject: obj)
			ifTrue:
				[coInterpreter print: 'young object '; printHex: obj; print: ' is free'; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[((self isMarked: obj) not and: [excludeUnmarkedNewSpaceObjs]) ifFalse:
					[(self isRemembered: obj) ifTrue:
						[coInterpreter print: 'young object '; printHex: obj; print: ' is remembered'; cr.
						 self eek.
						 ok := false]].
					 (self isForwarded: obj)
						ifTrue:
							[fieldOop := self fetchPointer: 0 ofMaybeForwardedObject: obj.
							 (heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
								[coInterpreter print: 'object leak in forwarder '; printHex: obj; print: ' to unmapped '; printHex: fieldOop; cr.
								 self eek.
								 ok := false]]
						ifFalse:
							[classOop := self classOrNilAtIndex: (classIndex := self classIndexOf: obj).
							 (classIndicesShouldBeValid
							  and: [classOop = nilObj
							  and: [(self isHiddenObj: obj) not]]) ifTrue:
								[coInterpreter print: 'object leak in '; printHex: obj; print: ' invalid class index '; printHex: classIndex; print: ' -> '; print: (classOop ifNil: ['nil'] ifNotNil: ['nilObj']); cr.
								 self eek.
								 ok := false].
							 0 to: (self numPointerSlotsOf: obj) - 1 do:
								[:fi|
								 fieldOop := self fetchPointer: fi ofObject: obj.
								 (self isNonImmediate: fieldOop) ifTrue:
									[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
										[coInterpreter print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
										 self eek.
										 ok := false]]]]]].
	self allOldSpaceEntitiesDo:
		[:obj| | containsYoung fieldOop classIndex classOop |
		(self isFreeObject: obj)
			ifTrue:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) ~= 0 ifTrue:
					[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' is mapped?! '; cr.
					 self eek.
					 ok := false].
				 fieldOop := self fetchPointer: self freeChunkNextIndex ofFreeChunk: obj.
				 (fieldOop ~= 0
				 and: [(heapMap heapMapAtWord: (self pointerForOop: obj)) ~= 0]) ifTrue:
					[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' @ 0 = '; printHex: fieldOop; print: ' is mapped'; cr.
					 self eek.
					 ok := false].
				(self isLargeFreeObject: obj) ifTrue:
					[self freeChunkParentIndex to: self freeChunkLargerIndex do:
						[:fi|
						 fieldOop := self fetchPointer: fi ofFreeChunk: obj.
						 (fieldOop ~= 0
						 and: [(heapMap heapMapAtWord: (self pointerForOop: obj)) ~= 0]) ifTrue:
							[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; print: ' is mapped'; cr.
							 self eek.
							 ok := false].]]]
			ifFalse:
				[containsYoung := false.
				 (self isRemembered: obj) ifTrue:
					[numRememberedObjectsInHeap := numRememberedObjectsInHeap + 1.
					 (scavenger isInRememberedSet: obj) ifFalse:
						[coInterpreter print: 'remembered object '; printHex: obj; print: ' is not in remembered table'; cr.
						 self eek.
						 ok := false]].
				 (self isForwarded: obj)
					ifTrue:
						[fieldOop := self fetchPointer: 0 ofMaybeForwardedObject: obj.
						 (heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
							[coInterpreter print: 'object leak in forwarder '; printHex: obj; print: ' to unmapped '; printHex: fieldOop; cr.
							 self eek.
							 ok := false].
						 (self isReallyYoung: fieldOop) ifTrue:
							[containsYoung := true]]
					ifFalse:
						[classOop := self classOrNilAtIndex: (classIndex := self classIndexOf: obj).
						 (classIndicesShouldBeValid
						  and: [classOop = nilObj
						  and: [classIndex > self lastClassIndexPun]]) ifTrue:
							[coInterpreter print: 'object leak in '; printHex: obj; print: ' invalid class index '; printHex: classIndex; print: ' -> '; print: (classOop ifNil: ['nil'] ifNotNil: ['nilObj']); cr.
							 self eek.
							 ok := false].
						 0 to: (self numPointerSlotsOf: obj) - 1 do:
							[:fi|
							 fieldOop := self fetchPointer: fi ofObject: obj.
							 (self isNonImmediate: fieldOop) ifTrue:
								[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
									[coInterpreter print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
									 self eek.
									 ok := false].
								 "don't be misled by CogMethods; they appear to be young, but they're not"
								 (self isReallyYoung: fieldOop) ifTrue:
									[containsYoung := true]]]].
				 containsYoung ifTrue:
					[(self isRemembered: obj) ifFalse:
						[coInterpreter print: 'unremembered object '; printHex: obj; print: ' contains young oop(s)'; cr.
						 self eek.
						 ok := false]]]].
	numRememberedObjectsInHeap ~= scavenger rememberedSetSize ifTrue:
		[coInterpreter
			print: 'root count mismatch. #heap roots ';
			printNum: numRememberedObjectsInHeap;
			print: '; #roots ';
			printNum: scavenger rememberedSetSize;
			cr.
		self eek.
		"But the system copes with overflow..."
		self flag: 'no support for remembered set overflow yet'.
		"ok := rootTableOverflowed and: [needGCFlag]"].
	scavenger rememberedSetWithIndexDo:
		[:obj :i|
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned oop in remembered set @ '; printNum: i; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[coInterpreter print: 'object leak in remembered set @ '; printNum: i; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]
					ifFalse:
						[(self isYoung: obj) ifTrue:
							[coInterpreter print: 'non-root in remembered set @ '; printNum: i; print: ' = '; printHex: obj; cr.
							 self eek.
							 ok := false]]]].
	self objStack: mournQueue do:
		[:i :page| | obj |
		obj := self fetchPointer: i ofObject: page.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned oop in mournQueue @ '; printNum: i; print: ' in '; printHex: page; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(excludeUnmarkedNewSpaceObjs and: [(self isYoung: obj) and: [(self isMarked: obj) not]]) ifFalse:
					[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0 ifTrue:
						[coInterpreter print: 'object leak in mournQueue @ '; printNum: i; print: ' in '; printHex: page; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]]]].
	1 to: remapBufferCount do:
		[:ri| | obj |
		obj := remapBuffer at: ri.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned remapRoot @ '; printNum: ri; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0 ifTrue:
					[coInterpreter print: 'object leak in remapRoots @ '; printNum: ri; print: ' = '; printHex: obj; cr.
					 self eek.
					 ok := false]]].
	1 to: extraRootCount do:
		[:ri| | obj |
		obj := (extraRoots at: ri) at: 0.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned extraRoot @ '; printNum: ri; print: ' => '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0 ifTrue:
					[coInterpreter print: 'object leak in extraRoots @ '; printNum: ri; print: ' => '; printHex: obj; cr.
					 self eek.
					 ok := false]]].
	^ok