private - signum
sigIgnoreNumber
	"Ignore action for a signal"

	<returnTypeC: 'void *'>
	^self cCode: [#'SIG_IGN'] inSmalltalk: [1]
