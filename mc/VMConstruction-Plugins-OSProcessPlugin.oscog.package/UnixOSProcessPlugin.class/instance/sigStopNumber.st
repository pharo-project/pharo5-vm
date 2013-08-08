private - signum
sigStopNumber
	"Stop process"

	^self cCode: [#SIGSTOP] inSmalltalk: [17]
