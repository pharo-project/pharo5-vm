private - signum
sigDefaultNumber
	"Default action for a signal"

	<returnTypeC: 'void *'>
	^self cCode: [#'SIG_DFL'] inSmalltalk: [0]
