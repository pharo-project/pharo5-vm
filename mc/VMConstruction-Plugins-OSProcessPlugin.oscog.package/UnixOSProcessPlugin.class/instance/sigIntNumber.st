private - signum
sigIntNumber
	"Interrupt (ANSI)."

	^self cCode: [#SIGINT] inSmalltalk: [2]
