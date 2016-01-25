primitive support
allObjects
	"Attempt to answer an array of all objects, excluding those that may
	 be garbage collected as a side effect of allocating the result array.
	 If no memory is available answer the number of objects as a SmallInteger.
	 Since objects are at least 16 bytes big, and the largest SmallInteger covers
	 1/4 of the address space, the count can never overflow."
	| freeChunk ptr start limit count bytes |
	MarkObjectsForEnumerationPrimitives ifTrue:
		[self markObjects: true]. "may not want to revive objects unnecessarily; but marking is sloooow."
	freeChunk := self allocateLargestFreeChunk.
	ptr := start := freeChunk + self baseHeaderSize.
	limit := self addressAfter: freeChunk.
	count := 0.
	self allHeapEntitiesDo:
		[:obj| "continue enumerating even if no room so as to unmark all objects."
		 (MarkObjectsForEnumerationPrimitives
				ifTrue: [self isMarked: obj]
				ifFalse: [true]) ifTrue:
			[(self isNormalObject: obj)
				ifTrue:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[self setIsMarkedOf: obj to: false].
					 count := count + 1.
					 ptr < limit ifTrue:
						[self longAt: ptr put: obj.
						 ptr := ptr + self bytesPerOop]]
				ifFalse:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[(self isSegmentBridge: obj) ifFalse:
							[self setIsMarkedOf: obj to: false]]]]].
	self assert: (self isEmptyObjStack: markStack).
	MarkObjectsForEnumerationPrimitives
		ifTrue:
			[self assert: self allObjectsUnmarked.
			 self emptyObjStack: weaklingStack]
		ifFalse:
			[self assert: (self isEmptyObjStack: weaklingStack)].
	self assert: count >= self numSlotsMask.
	(count > (ptr - start / self bytesPerOop) "not enough room"
	 or: [limit ~= ptr and: [limit - ptr <= self allocationUnit]]) ifTrue: "can't split a single word"
		[self freeChunkWithBytes: (self bytesInObject: freeChunk) at: (self startOfObject: freeChunk).
		 self checkFreeSpace: GCModeFull.
		 ^self integerObjectOf: count].
	bytes := self largeObjectBytesForSlots: count.
	start := self startOfObject: freeChunk.
	self freeChunkWithBytes: limit - start - bytes at: start + bytes.
	totalFreeOldSpace := totalFreeOldSpace - bytes.
	self rawOverflowSlotsOf: freeChunk put: count.
	self set: freeChunk classIndexTo: ClassArrayCompactIndex formatTo: self arrayFormat.
	self possibleRootStoreInto: freeChunk.
	self checkFreeSpace: GCModeFull.
	self runLeakCheckerFor: GCModeFull.
	^freeChunk
	
	