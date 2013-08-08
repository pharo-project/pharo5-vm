private - signum
sigHoldNumber
	"Hold action for a signal"

	<returnTypeC: 'void *'>
	^self cCode: [#'SIG_HOLD'] inSmalltalk: [5]
