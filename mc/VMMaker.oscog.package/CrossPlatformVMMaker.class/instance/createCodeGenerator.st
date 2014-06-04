initialize
createCodeGenerator
	"Set up a CCodeGenerator for this VMMaker - A cross platform tree leaves it up to the makefiles to decide whether to use the global struct or not."
	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		structDefDefine: 'USE_GLOBAL_STRUCT';
		logger: logger;
		options: optionsDictionary;
		yourself