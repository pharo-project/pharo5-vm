private - signum
sigTermNumber
	"Termination signal. This is the default signal sent by the unix kill(1) command."

	^self cCode: [#SIGTERM] inSmalltalk: [15]
