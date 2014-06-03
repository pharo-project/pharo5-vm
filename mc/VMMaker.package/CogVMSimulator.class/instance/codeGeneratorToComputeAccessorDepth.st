primitive support
codeGeneratorToComputeAccessorDepth
	^VMMaker new
		cogitClass: (Smalltalk classNamed: (self class initializationOptions
												at: #Cogit
												ifAbsent: [self class cogitClass name]));
		buildCodeGeneratorForInterpreter: CoInterpreterPrimitives
		includeAPIMethods: false
		initializeClasses: false