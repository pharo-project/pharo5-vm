private - signum
sigQuitNumber
	"Quit from keyboard"

	^self cCode: [#SIGQUIT] inSmalltalk: [3]
