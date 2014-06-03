instance creation
chooseAndInitCogitClassWithOpts: opts
	| classOrSymbol |
	classOrSymbol := opts at: #Cogit ifAbsent: [Cogit chooseCogitClass].
	classOrSymbol isSymbol ifTrue:
		[classOrSymbol := Smalltalk classNamed: classOrSymbol].
	(CoInterpreter classPool at: #CogitClass put: (classOrSymbol)) initializeWithOptions: opts