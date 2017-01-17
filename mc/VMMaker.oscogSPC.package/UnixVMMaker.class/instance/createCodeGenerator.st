initialisation
createCodeGenerator

	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		logger: logger;
		options: optionsDictionary;
		yourself