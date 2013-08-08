running
startUp
	"UnixProcess stdOut print: parameters; nl."
	(parameters includesKey: '-doit') ifTrue:
		[Compiler evaluate: (parameters at: '-doit').
		 Smalltalk quitPrimitive]