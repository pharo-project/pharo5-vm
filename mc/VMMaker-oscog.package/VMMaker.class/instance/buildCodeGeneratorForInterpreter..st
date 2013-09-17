generate sources
buildCodeGeneratorForInterpreter: getAPIMethods
	"Answer the code generator for translating the interpreter."

	| cg interpreterClass interpreterClasses apicg |
	interpreterClasses := OrderedCollection new.

	(cg := self createCodeGenerator) vmClass: (interpreterClass := self interpreterClass).

	[interpreterClass ~~ VMClass] whileTrue:
		[interpreterClasses addFirst: interpreterClass.
		 interpreterClass := interpreterClass superclass].
	
	cg vmClass objectMemoryClass ifNotNil:
		[:objectMemoryClass|
		interpreterClass := objectMemoryClass.
		[interpreterClass ~~ VMClass] whileTrue:
			[interpreterClasses addFirst: interpreterClass.
			 interpreterClass := interpreterClass superclass]].

	interpreterClasses addFirst: VMClass.
	interpreterClasses addAllLast: (((self interpreterClass ancilliaryClasses: optionsDictionary) reject: [:class| class isStructClass]) copyWithout: cg vmClass objectMemoryClass).
	(cg structClassesForTranslationClasses: interpreterClasses) do:
		[:structClass|
		structClass initialize.
		cg addStructClass: structClass].

	interpreterClasses do:
		[:ic|
		(ic respondsTo: #initializeWithOptions:)
			ifTrue: [ic initializeWithOptions: optionsDictionary]
			ifFalse: [ic initialize]].

	interpreterClasses do: [:ic| cg addClass: ic].

	(getAPIMethods
	and: [self interpreterClass needsCogit]) ifTrue:
		[apicg := self buildCodeGeneratorForCogit: false.
		 cg apiMethods: apicg selectAPIMethods].

	^cg