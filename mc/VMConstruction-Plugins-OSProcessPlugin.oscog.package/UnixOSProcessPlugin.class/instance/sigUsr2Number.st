private - signum
sigUsr2Number
	"User defined signal number 2. This is value is platform-dependent, so the
	inSmalltalk default of 12 may be wrong on some platforms."

	^ self cCode: 'SIGUSR2' inSmalltalk: [12]
