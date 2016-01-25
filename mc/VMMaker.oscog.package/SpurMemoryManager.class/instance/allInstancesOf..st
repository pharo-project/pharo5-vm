primitive support
allInstancesOf: aClass
	"Attempt to answer an array of all objects, excluding those that may
	 be garbage collected as a side effect of allocating the result array.
	 If no memory is available answer the number of instances as a SmallInteger.
	 Since objects are at least 16 bytes big, and the largest SmallInteger covers
	 1/4 of the address space, the count can never overflow."
	| classIndex freeChunk ptr start limit count bytes |
	classIndex := self rawHashBitsOf: aClass.
	classIndex = 0 ifTrue:
		[freeChunk := self allocateSlots: 0 format: self arrayFormat classIndex: ClassArrayCompactIndex.
		 ^freeChunk].
	MarkObjectsForEnumerationPrimitives ifTrue:
		[self markObjects: true]. "may not want to revive objects unnecessarily; but marking is sloooow."
	freeChunk := self allocateLargestFreeChunk.
	start := freeChunk + self baseHeaderSize.
	limit := self addressAfter: freeChunk.
	(self isClassAtUniqueIndex: aClass)
		ifTrue:
			[self uniqueIndex: classIndex allInstancesInto: start limit: limit resultsInto: [:c :p| count := c. ptr := p]]
		ifFalse:
			[self ambiguousClass: aClass allInstancesInto: start limit: limit resultsInto: [:c :p| count := c. ptr := p]].
	self assert: (self isEmptyObjStack: markStack).
	MarkObjectsForEnumerationPrimitives
		ifTrue:
			[self assert: self allObjectsUnmarked.
			 self emptyObjStack: weaklingStack]
		ifFalse:
			[self assert: (self isEmptyObjStack: weaklingStack)].
	(count > (ptr - start / self bytesPerOop) "not enough room"
	 or: [limit ~= ptr and: [limit - ptr <= self allocationUnit]]) ifTrue: "can't split a single word"
		[self freeObject: freeChunk.
		 ^self integerObjectOf: count].
	count < self numSlotsMask ifTrue:
		[| smallObj |
		 smallObj := self allocateSlots: count format: self arrayFormat classIndex: ClassArrayCompactIndex.
		 0 to: count - 1 do:
			[:i|
			self storePointerUnchecked: i ofObject: smallObj withValue: (self fetchPointer: i ofFreeChunk: freeChunk)].
		 self freeChunkWithBytes: (self bytesInObject: freeChunk) at: (self startOfObject: freeChunk).
		 self beRootIfOld: smallObj.
		 self checkFreeSpace: GCModeFull.
		 ^smallObj].
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
	
	