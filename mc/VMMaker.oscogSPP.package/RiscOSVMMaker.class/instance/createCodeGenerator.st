initialize
createCodeGenerator
"set up a CCodeGenerator for this VMMaker - RiscOS uses the global struct and no local def of the structure because of the global register trickery"
	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		logger: logger;
		options: optionsDictionary;
		yourself