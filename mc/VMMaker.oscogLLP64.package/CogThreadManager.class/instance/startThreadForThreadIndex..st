scheduling
startThreadForThreadIndex: index
	index > numThreads ifTrue:
		[(self growThreadInfosToAtLeast: index) ifFalse:
			[^false]].
	^self startThreadForThreadInfo: (self vmThreadAt: index)