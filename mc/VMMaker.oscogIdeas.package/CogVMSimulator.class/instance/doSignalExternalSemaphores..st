process primitive support
doSignalExternalSemaphores: minTableSize
	"This is a non-thread-safe simulation.  See platforms/Cross/vm/sqExternalSemaphores.c
	 for the real code.  For the benefit of the SocketPluginSimulator, do a yield every 100
	 virtual microseconds."
	| now switched |
	now := self ioUTCMicroseconds.
	now - lastYieldMicroseconds >= 100 ifTrue:
		[lastYieldMicroseconds := now.
		 Processor yield].

	switched := false.
	1 to: (minTableSize min: externalSemaphoreSignalRequests size) do:
		[:i| | responses |
		responses := externalSemaphoreSignalResponses at: i.
		[responses < (externalSemaphoreSignalRequests at: i)] whileTrue:
			[(self doSignalSemaphoreWithIndex: i) ifTrue:
				[switched := true].
			 externalSemaphoreSignalResponses at: i put: (responses := responses + 1)]].
	^switched