thread set
growThreadInfosToAtLeast: index
	"Grow the thread infos to at least index in numThreadsIncrement quanta."
	| newThreads newNumThreads |
	<var: #newThreads type: #'CogVMThread **'>
	<inline: false>
	memoryIsScarce ifTrue:
		[^false].
	newNumThreads := index + numThreadsIncrement - 1 // numThreadsIncrement * numThreadsIncrement.
	newNumThreads >= self maxNumThreads ifTrue:
		[^false].
	"Since 0 is not a valid index we allocate one extra CogVMThread and use 1-relative indices."
	newThreads := self cCode: 'realloc(GIV(threads), (newNumThreads + 1) * sizeof(CogVMThread *))'
						inSmalltalk: [(Array new: newNumThreads)
										replaceFrom: 1 to: numThreads
										with: threads startingAt: 1].
	(newThreads notNil
	 and: [self populate: newThreads from: numThreads + 1 to: newNumThreads]) ifFalse:
		[self free: newThreads.
		 memoryIsScarce := true.
		 ^false].
	threads := newThreads.
	numThreads := newNumThreads.
	^true