initialize
createCodeGenerator
"set up a CCodeGenerator for this VMMaker"
	^CCodeGenerator new initialize
		logger: logger;
		options: optionsDictionary;
		yourself