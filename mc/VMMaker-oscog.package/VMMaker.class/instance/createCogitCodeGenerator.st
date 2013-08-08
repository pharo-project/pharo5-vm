initialize
createCogitCodeGenerator
	^CCodeGenerator new initialize
		logger: logger;
		options: optionsDictionary;
		yourself