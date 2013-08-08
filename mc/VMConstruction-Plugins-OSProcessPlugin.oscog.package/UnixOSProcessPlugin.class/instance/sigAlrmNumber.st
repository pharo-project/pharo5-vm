private - signum
sigAlrmNumber
	"Timer signal from alarm(2)"

	^self cCode: [#SIGALRM] inSmalltalk: [14]
