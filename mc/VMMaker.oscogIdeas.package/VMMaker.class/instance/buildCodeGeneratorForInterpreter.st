generate sources
buildCodeGeneratorForInterpreter
	"Answer the code generator for translating the interpreter."

	^(Smalltalk classNamed: #CurrentReadOnlySourceFiles)
		ifNil: [self
				buildCodeGeneratorForInterpreter: self interpreterClass
				includeAPIMethods: true
				initializeClasses: true]
		ifNotNil:
			[:crosf|
			 crosf cacheDuring:
				[self
					buildCodeGeneratorForInterpreter: self interpreterClass
					includeAPIMethods: true
					initializeClasses: true]]