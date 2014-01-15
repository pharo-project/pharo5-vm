generate sources
buildCodeGeneratorForInterpreter: getAPIMethods
	"Answer the code generator for translating the interpreter."

	| cg interpreterClass interpreterClasses structClasses apicg |
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
	interpreterClasses addAllLast: (self interpreterClass ancilliaryClasses copyWithout: cg vmClass objectMemoryClass).
	structClasses := Set new.
	interpreterClasses do: [:class| structClasses addAll: class ancilliaryStructClasses].
	(Class superclassOrder: structClasses asArray) do:
		[:structClass|
		structClass initialize. ].

	interpreterClasses do:
		[:ic|
		(ic respondsTo: #initializeWithOptions:)
			ifTrue: [ic initializeWithOptions: optionsDictionary]
			ifFalse: [ic initialize]].

	(Class superclassOrder: structClasses asArray) do:
		[:structClass|
		cg addStructClass: structClass].

	interpreterClasses do: [:ic| cg addClass: ic].

	(getAPIMethods
	and: [self interpreterClass needsCogit]) ifTrue:
		[apicg := self buildCodeGeneratorForCogit: false.
		 cg apiMethods: apicg selectAPIMethods].

	^cg