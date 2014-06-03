generate sources
buildCodeGeneratorForCogit
	"Answer the code generator for translating the cogit."

	^self
		buildCodeGeneratorForCogit: self cogitClass
		includeAPIMethods: true
		initializeClasses: true