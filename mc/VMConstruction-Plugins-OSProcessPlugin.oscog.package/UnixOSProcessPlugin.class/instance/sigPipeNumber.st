private - signum
sigPipeNumber
	"Broken pipe (POSIX)."

	^self cCode: [#SIGPIPE] inSmalltalk: [13]
