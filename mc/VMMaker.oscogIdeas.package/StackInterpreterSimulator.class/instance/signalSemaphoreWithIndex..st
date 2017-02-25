process primitive support
signalSemaphoreWithIndex: index
	"This is a simulation.  See platforms/Cross/vm/sqExternalSemaphores.c for the real code.
	 Thanks to Levente Uzoni for making this version almost thread-safe (in Smalltalk)"
	<doNotGenerate>
	| originalResponses newRequests newResponses |
	index <= 0 ifTrue: [^false].
	index > externalSemaphoreSignalRequests size ifTrue:
		[newRequests := Array new: 1 << index highBit withAll: 0.
		 newResponses := newRequests shallowCopy].
	"This is a lock-free thread-safe grow...; thanks Levente"
	originalResponses := externalSemaphoreSignalResponses.
	[index > externalSemaphoreSignalRequests size] whileTrue:
		[newRequests
			replaceFrom: 1
			to: externalSemaphoreSignalRequests size
			with: externalSemaphoreSignalRequests
			startingAt: 1.
		 newResponses
			replaceFrom: 1
			to: externalSemaphoreSignalResponses size
			with: externalSemaphoreSignalResponses
			startingAt: 1.
		 externalSemaphoreSignalResponses == originalResponses "This should always be true."
			ifTrue:
				[externalSemaphoreSignalRequests := newRequests.
				 externalSemaphoreSignalResponses := newResponses]
			ifFalse:
				[originalResponses := externalSemaphoreSignalResponses]].
	"This is not thread-safe however..."
	externalSemaphoreSignalRequests
		at: index
		put: (externalSemaphoreSignalRequests at: index) + 1.
	^true