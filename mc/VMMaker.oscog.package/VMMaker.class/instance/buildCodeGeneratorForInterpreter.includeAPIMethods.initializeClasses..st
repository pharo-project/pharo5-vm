generate sources
buildCodeGeneratorForInterpreter: interpreterClass includeAPIMethods: getAPIMethods initializeClasses: initializeClasses
	"Answer the code generator for translating the interpreter."

	| cg interpreterClasses |
	initializeClasses ifTrue:
		[interpreterClass initializeWithOptions: optionsDictionary.
		 interpreterClass hasCogit ifTrue:
			[interpreterClass cogitClass initializeWithOptions: optionsDictionary]].

	(cg := self createCodeGenerator) vmClass: interpreterClass.

	"Construct interpreterClasses as all classes from interpreterClass &
	 objectMemoryClass up to VMClass in superclass to subclass order."
	interpreterClasses := OrderedCollection new.
	{interpreterClass. interpreterClass objectMemoryClass} do:
		[:vmClass| | theClass |
		 theClass := vmClass.
		 [theClass ~~ VMClass] whileTrue:
			[interpreterClasses addFirst: theClass.
			 theClass := theClass superclass]].
	interpreterClasses
		addFirst: VMClass;
		addAllLast: (cg nonStructClassesForTranslationClasses: interpreterClasses).

	initializeClasses ifTrue:
		[interpreterClasses do:
			[:ic|
			(ic respondsTo: #initializeWithOptions:)
				ifTrue: [ic initializeWithOptions: optionsDictionary]
				ifFalse: [ic initialize]].
		 (cg structClassesForTranslationClasses: interpreterClasses) do:
			[:structClass| structClass initialize]].

	cg addStructClasses: (cg structClassesForTranslationClasses: interpreterClasses).

	interpreterClasses do: [:ic| cg addClass: ic].

	getAPIMethods ifTrue:
		[interpreterClass cogitClass ifNotNil:
			[:cogitClass|
			 cg includeAPIFrom: (self
									buildCodeGeneratorForCogit: cogitClass
									includeAPIMethods: false
									initializeClasses: false)]].

	^cg