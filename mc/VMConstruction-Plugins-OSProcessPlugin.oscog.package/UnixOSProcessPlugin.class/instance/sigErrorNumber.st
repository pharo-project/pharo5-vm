private - signum
sigErrorNumber
	"Error return from signal()"

	<returnTypeC: 'void *'>
	^self cCode: [#'SIG_ERR'] inSmalltalk: [-1]
