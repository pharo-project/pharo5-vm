compaction - asserts
checkTraversableSortedFreeList
	| prevFree prevPrevFree freeChunk |
	<api>
	<inline: false>
	prevFree := prevPrevFree := 0.
	firstFreeChunk = 0 ifTrue:
		[^lastFreeChunk = 0].
	freeChunk := firstFreeChunk.
	manager allOldSpaceEntitiesDo:
		[:o| | objOop next limit |
		(manager isFreeObject: o) ifTrue:
			[self assert: o = freeChunk.
			 next := self nextInSortedFreeListLink: freeChunk given: prevFree.
			 limit := next = 0 ifTrue: [manager endOfMemory] ifFalse: [next].
			 "coInterpreter transcript cr; print: freeChunk; tab; print: o; tab; print: prevFree; nextPutAll: '<->'; print: next; flush."
			 objOop := freeChunk.
			 [self oop: (objOop := manager objectAfter: objOop) isLessThan: limit] whileTrue:
				[self assert: (manager isFreeObject: objOop) not].
			 prevPrevFree := prevFree.
			 prevFree := freeChunk.
			 freeChunk := next]].
	self assert: prevFree = lastFreeChunk.
	self assert: (self nextInSortedFreeListLink: lastFreeChunk given: 0) = prevPrevFree.
	self assert: freeChunk = 0.
	^true