process primitive support
signalSemaphoreWithIndex: index
	"This is a non-thread-safe simulation.  See platforms/Cross/vm/sqExternalSemaphores.c
	 for the real code."
	index <= 0 ifTrue: [^false].
	index > externalSemaphoreSignalRequests size ifTrue:
		[| newRequests newResponses |
		newRequests := Array new: 1 << index highBit withAll: 0.
		newResponses := newRequests copy.
		newRequests
			replaceFrom: 1
			to: externalSemaphoreSignalRequests size
			with: externalSemaphoreSignalRequests
			startingAt: 1.
		newResponses
			replaceFrom: 1
			to: externalSemaphoreSignalResponses size
			with: externalSemaphoreSignalResponses
			startingAt: 1].
	externalSemaphoreSignalRequests
		at: index
		put: (externalSemaphoreSignalRequests at: index) + 1.
	^true