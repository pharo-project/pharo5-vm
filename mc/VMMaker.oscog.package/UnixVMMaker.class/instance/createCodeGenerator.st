initialisation
createCodeGenerator

	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		logger: logger;
		yourself