primitive support
codeGeneratorToComputeAccessorDepth
	^VMMaker new
		buildCodeGeneratorForInterpreter: self class primitivesClass
		includeAPIMethods: false
		initializeClasses: false