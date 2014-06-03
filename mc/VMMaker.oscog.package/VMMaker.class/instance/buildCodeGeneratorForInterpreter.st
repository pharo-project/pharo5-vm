generate sources
buildCodeGeneratorForInterpreter
	"Answer the code generator for translating the interpreter."

	^self
		buildCodeGeneratorForInterpreter: self interpreterClass
		includeAPIMethods: true
		initializeClasses: true