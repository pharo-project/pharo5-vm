simulation only
checkTraversableSortedFreeList
	| prevFree freeChunk next |
	<api>
	<inline: false>
	prevFree := 0.
	freeChunk := firstFreeChunk.
	self allOldSpaceEntitiesDo:
		[:o| | objOop |
		(self isFreeObject: o) ifTrue:
			[self assert: o = freeChunk.
			 next := self nextInSortedFreeListLink: freeChunk given: prevFree.
			 "coInterpreter transcript cr; print: freeChunk; tab; print: o; tab; print: prevFree; nextPutAll: '<->'; print: next; flush."
			 objOop := freeChunk.
			 [(objOop := self objectAfter: objOop) < next] whileTrue:
				[self assert: (self isFreeObject: objOop) not].
			 prevFree := freeChunk.
			 freeChunk := next]].
	self assert: prevFree = lastFreeChunk.
	self assert: freeChunk = 0