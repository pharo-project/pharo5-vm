initialize
createCodeGenerator
	"Set up a CCodeGenerator for this VMMaker - On Windows we use the gcc 2.95.x compiler
	 which does better without the global struct."
	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		structDefDefine: '0';
		"structDefDefine: 'defined(PPC) || defined(_POWER) || defined(__powerpc__) || defined(__ppc__)';"
		logger: logger;
		options: optionsDictionary;
		yourself