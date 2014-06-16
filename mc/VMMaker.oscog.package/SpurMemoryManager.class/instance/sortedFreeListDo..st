compaction
sortedFreeListDo: aBlock
	"Evaluate aBlock with ascending entries in the free list"
	| free nextFree prevFree prevPrevFree |
	<var: #free type: #usqInt>
	<var: #nextFree type: #usqInt>
	<var: #prevFree type: #usqInt>
	<var: #prevPrevFree type: #usqInt>
	<inline: true>
	free := firstFreeChunk.
	prevPrevFree := prevFree := 0.
	[free ~= 0] whileTrue:
		[nextFree := self nextInSortedFreeListLink: free given: prevFree.
		 self assert: (self isFreeObject: free).
		 self assert: (nextFree = 0 or: [nextFree > free and: [self isFreeObject: nextFree]]).
		 self assert: (prevFree = 0 or: [prevFree < free]).
	 	 aBlock value: free.
		 prevPrevFree := prevFree.
		 prevFree := free.
		 free := nextFree]