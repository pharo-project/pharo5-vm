simulation only
checkTraversableSortedFreeList
	| prevFree freeChunk |
	<api>
	<inline: false>
	prevFree := 0.
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
			 prevFree := freeChunk.
			 freeChunk := next]].
	self assert: prevFree = lastFreeChunk.
	self assert: freeChunk = 0.
	^true