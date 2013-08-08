private - signum
sigContNumber
	"Continue if stopped"

	^self cCode: [#SIGCONT] inSmalltalk: [19]
