compaction
sortedFreeListPairwiseReverseDo: aBinaryBlock
	"Evaluate aBinaryBlock with adjacent entries in the free list, from
	 high address to low address.  The second argument is in fact the
	 start of the next free chunk, not the free chunk itself.  Use
	 endOfMemory - bridgeSize as the second argument in the first evaluation."
	| free prevFree prevPrevFree |
	<var: #free type: #usqInt>
	<var: #prevFree type: #usqInt>
	<var: #prevPrevFree type: #usqInt>
	<inline: true>
	free := lastFreeChunk.
	prevPrevFree := prevFree := 0.
	[free ~= 0] whileTrue:
		[aBinaryBlock value: free value: (prevFree = 0
											ifTrue: [endOfMemory - self bridgeSize]
											ifFalse: [self startOfObject: prevFree]).
		 "post evaluation of aBinaryBlock the value of free may be invalid
		  because moveARunOfObjectsStartingAt:upTo: may have filled it.
		  So reconstruct the position in the enumeration."
		 prevFree = 0
			ifTrue:
				[self assert: free = lastFreeChunk.
				 prevFree := lastFreeChunk.
				 free := self nextInSortedFreeListLink: lastFreeChunk given: 0]
			ifFalse:
				[self assert: (self isFreeObject: prevFree).
				 prevPrevFree = 0
					ifTrue:
						[prevPrevFree := lastFreeChunk.
						 prevFree := self nextInSortedFreeListLink: lastFreeChunk given: 0]
					ifFalse:
						[self assert: (self isFreeObject: prevPrevFree).
						 free := self nextInSortedFreeListLink: prevFree given: prevPrevFree.
						 prevPrevFree := prevFree.
						 prevFree := free].
				 free := self nextInSortedFreeListLink: prevFree given: prevPrevFree]]