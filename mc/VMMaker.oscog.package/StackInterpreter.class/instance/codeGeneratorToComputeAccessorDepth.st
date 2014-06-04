primitive support
codeGeneratorToComputeAccessorDepth
	^VMMaker new
		buildCodeGeneratorForInterpreter: StackInterpreterPrimitives
		includeAPIMethods: false
		initializeClasses: false