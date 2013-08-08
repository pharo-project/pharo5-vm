generate sources
buildCodeGeneratorForCogit: getAPIMethods
	"Answer the code generator for translating the cogit."

	| cg cogitClass cogitClasses apicg |
	cg := self createCogitCodeGenerator.

	cg vmClass: (cogitClass := self cogitClass).
	{ cogitClass. self interpreterClass } do:
		[:cgc|
		(cgc respondsTo: #initializeWithOptions:)
			ifTrue: [cgc initializeWithOptions: optionsDictionary]
			ifFalse: [cgc initialize]].

	cogitClasses := OrderedCollection new.
	[cogitClasses addFirst: cogitClass.
	 cogitClass ~~ Cogit
	 and: [cogitClass inheritsFrom: Cogit]] whileTrue:
		[cogitClass := cogitClass superclass].
	cogitClasses addFirst: VMClass.
	cogitClasses addAllLast: self cogitClass ancilliaryClasses.
	cogitClasses do: [:cgc| cg addClass: cgc].
	(cg structClassesForTranslationClasses: cogitClasses) do:
		[:structClass| cg addStructClass: structClass].

	getAPIMethods ifTrue:
		[apicg := self buildCodeGeneratorForInterpreter: false.
		 cg apiMethods: apicg selectAPIMethods].

	^cg