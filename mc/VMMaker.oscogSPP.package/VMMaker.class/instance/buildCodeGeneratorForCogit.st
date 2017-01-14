generate sources
buildCodeGeneratorForCogit
	"Answer the code generator for translating the cogit."

	^(Smalltalk classNamed: #CurrentReadOnlySourceFiles)
		ifNil: [self
				buildCodeGeneratorForCogit: self interpreterClass cogitClass
				includeAPIMethods: true
				initializeClasses: true]
		ifNotNil:
			[:crosf|
			 crosf cacheDuring:
				[self
					buildCodeGeneratorForCogit: self interpreterClass cogitClass
					includeAPIMethods: true
					initializeClasses: true]]