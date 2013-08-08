private - signal handers
restoreDefaultSignalHandlers
	"Restore signal handlers to their original behaviors."

	| sigNum |
	<returnTypeC: 'void'>
	sigNum := 1.
	[sigNum <= self signalArraySize] whileTrue:
		[((self semaphoreIndices at: sigNum) > 0) ifTrue:
			[self setSignalNumber: sigNum handler: (self originalSignalHandlers at: sigNum).].
		sigNum := sigNum + 1]
