private - signal handers
restoreDefaultSignalHandlers
	"Restore signal handlers to their original behaviors."

	| sigNum |
	<returnTypeC: 'void'>
	semaIndices = nil "nil if in interpreter simulation"
		ifFalse: [sigNum := 1.
			[sigNum <= self signalArraySize] whileTrue:
				[((semaIndices at: sigNum) > 0) ifTrue:
					[self setSignalNumber: sigNum handler: (self originalSignalHandlers at: sigNum).].
				sigNum := sigNum + 1]]
