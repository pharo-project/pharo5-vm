private - signum
sigUsr1Number
	"User defined signal number 1. This is value is platform-dependent, so the
	inSmalltalk default of 30 may be wrong on some platforms."

	^self cCode: [#SIGUSR1] inSmalltalk: [30]
