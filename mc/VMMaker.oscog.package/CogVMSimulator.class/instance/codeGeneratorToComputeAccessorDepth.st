primitive support
codeGeneratorToComputeAccessorDepth
	^VMMaker new
		cogitClass: self class cogitClass;
		buildCodeGeneratorForInterpreter: CoInterpreterPrimitives
		includeAPIMethods: false
		initializeClasses: false