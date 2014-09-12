generate sources
buildCodeGeneratorForCogit
	"Answer the code generator for translating the cogit."

	^self
		buildCodeGeneratorForCogit: self interpreterClass cogitClass
		includeAPIMethods: true
		initializeClasses: true