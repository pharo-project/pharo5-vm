private - signum
sigChldNumber
	"Child status has changed (POSIX)."

	^self cCode: [#SIGCHLD] inSmalltalk: [20]
