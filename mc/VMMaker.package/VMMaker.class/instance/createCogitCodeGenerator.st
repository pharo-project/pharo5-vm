initialize
createCogitCodeGenerator
	^CCodeGenerator new
		vmMaker: self;
		logger: logger;
		options: optionsDictionary;
		yourself