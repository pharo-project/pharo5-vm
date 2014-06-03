primitive support
allInstancesOf: aClass
	"Attempt to answer an array of all objects, excluding those that may
	 be garbage collected as a side effect of allocating the result array.
	 If no memory is available answer the number of instances as a SmallInteger.
	 Since objects are at least 16 bytes big, and the largest SmallInteger covers
	 1/4 of the address space, the count can never overflow."
	| classIndex freeChunk ptr start limit count bytes |
	classIndex := self rawHashBitsOf: aClass.
	(classIndex = 0
	 or: [aClass ~~ (self classOrNilAtIndex: classIndex)]) ifTrue:
		[freeChunk := self allocateSlots: 0 format: self arrayFormat classIndex: ClassArrayCompactIndex.
		 ^freeChunk].
	MarkObjectsForEnumerationPrimitives ifTrue:
		[self markObjects]. "may not want to revive objects unnecessarily; but marking is sloooow."
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
					 (self classIndexOf: obj) = classIndex ifTrue:
					 	[count := count + 1.
						 ptr < limit ifTrue:
							[self longAt: ptr put: obj.
							 ptr := ptr + self bytesPerSlot]]]
				ifFalse:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[(self isSegmentBridge: obj) ifFalse:
							[self setIsMarkedOf: obj to: false]]]]].
	self assert: self allObjectsUnmarked.
	self assert: (self isEmptyObjStack: markStack).
	self emptyObjStack: weaklingStack.
	(count > (ptr - start / self bytesPerSlot) "not enough room"
	 or: [limit ~= ptr and: [limit - ptr <= self allocationUnit]]) ifTrue: "can't split a single word"
		[self freeObject: freeChunk.
		 ^self integerObjectOf: count].
	count < self numSlotsMask ifTrue:
		[| smallObj |
		 smallObj := self allocateSlots: count format: self arrayFormat classIndex: ClassArrayCompactIndex.
		 0 to: count - 1 do:
			[:i|
			self storePointerUnchecked: i ofObject: smallObj withValue: (self fetchPointer: i ofObject: freeChunk)].
		 self freeChunkWithBytes: (self bytesInObject: freeChunk) at: (self startOfObject: freeChunk).
		 self beRootIfOld: smallObj.
		 self checkFreeSpace.
		 ^smallObj].
	bytes := self largeObjectBytesForSlots: count.
	start := self startOfObject: freeChunk.
	self freeChunkWithBytes: limit - start - bytes at: start + bytes.
	totalFreeOldSpace := totalFreeOldSpace - bytes.
	self setOverflowNumSlotsOf: freeChunk to: count.
	self set: freeChunk classIndexTo: ClassArrayCompactIndex formatTo: self arrayFormat.
	self possibleRootStoreInto: freeChunk.
	self checkFreeSpace.
	self runLeakCheckerForFullGC: false.
	^freeChunk
	
	