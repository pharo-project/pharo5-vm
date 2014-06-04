initialize
createCodeGenerator
"set up a CCodeGenerator for this VMMaker"
	^CCodeGenerator new
		vmMaker: self;
		logger: logger;
		options: optionsDictionary;
		yourself