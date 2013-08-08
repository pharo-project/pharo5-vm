private - signum
sigAbrtNumber
	"Abort signal from abort(3)"

	^self cCode: [#SIGABRT] inSmalltalk: [6]
