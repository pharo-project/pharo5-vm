simulation only
checkTraversableSortedFreeList
	| prevFree prevPrevFree freeChunk |
	<api>
	<inline: false>
	prevFree := prevPrevFree := 0.
	firstFreeChunk = 0 ifTrue:
		[^lastFreeChunk = 0].
	freeChunk := firstFreeChunk.
	self allOldSpaceEntitiesDo:
		[:o| | objOop next limit |
		(self isFreeObject: o) ifTrue:
			[self assert: o = freeChunk.
			 next := self nextInSortedFreeListLink: freeChunk given: prevFree.
			 limit := next = 0 ifTrue: [endOfMemory] ifFalse: [next].
			 "coInterpreter transcript cr; print: freeChunk; tab; print: o; tab; print: prevFree; nextPutAll: '<->'; print: next; flush."
			 objOop := freeChunk.
			 [self oop: (objOop := self objectAfter: objOop) isLessThan: limit] whileTrue:
				[self assert: (self isFreeObject: objOop) not].
			 prevPrevFree := prevFree.
			 prevFree := freeChunk.
			 freeChunk := next]].
	self assert: prevFree = lastFreeChunk.
	self assert: (self nextInSortedFreeListLink: lastFreeChunk given: 0) = prevPrevFree.
	self assert: freeChunk = 0.
	^true