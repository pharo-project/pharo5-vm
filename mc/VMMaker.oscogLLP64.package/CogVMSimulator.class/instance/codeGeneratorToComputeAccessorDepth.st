primitive support
codeGeneratorToComputeAccessorDepth
	^VMMaker new
		buildCodeGeneratorForInterpreter: CoInterpreterPrimitives
		includeAPIMethods: false
		initializeClasses: false