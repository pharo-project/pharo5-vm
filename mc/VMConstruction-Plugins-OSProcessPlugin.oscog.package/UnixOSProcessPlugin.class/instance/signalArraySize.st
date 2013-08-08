initialize-release
signalArraySize
	"Number of possible signals for this OS plus one. The signal handler arrays
	declared in #declareCVarsIn: are this size."

	^ self cCode: 'NSIG' inSmalltalk: [65]
