generate sources
buildCodeGeneratorForCogit: cogitClass includeAPIMethods: getAPIMethods initializeClasses: initializeClasses
	"Answer the code generator for translating the cogit."

	| cg cogitClasses |
	cg := self createCogitCodeGenerator.

	cg vmClass: cogitClass.
	initializeClasses ifTrue:
		[{ cogitClass. self interpreterClass. self interpreterClass objectMemoryClass } do:
			[:cgc|
			(cgc respondsTo: #initializeWithOptions:)
				ifTrue: [cgc initializeWithOptions: optionsDictionary]
				ifFalse: [cgc initialize]]].

	cogitClasses := OrderedCollection withAll: (cogitClass withAllSuperclasses copyUpThrough: VMClass) reverse.
	cogitClasses addAllLast: ((cogitClass ancilliaryClasses: optionsDictionary) reject: [:class| class isStructClass]).
	cogitClasses do: [:cgc| cg addClass: cgc].
	"Now make sure to add struct classes that the most specific subclasses specify.
	 This makes sure that struct classes are ordered as the most specific cogitClass desires.
	 This must happen for references between the struct classes to be resolved in a specific order."
	cogitClasses := OrderedCollection with: cogitClass with: cogitClass objectRepresentationClass.
	cogitClasses addAll: ((cogitClass ancilliaryClasses: optionsDictionary) reject:
							[:class|
							 class isStructClass
							 or: [cogitClass objectRepresentationClass includesBehavior: class]]).
	cg addStructClasses: (cg structClassesForTranslationClasses: cogitClasses).

	getAPIMethods ifTrue:
		[cg includeAPIFrom: (self
								buildCodeGeneratorForInterpreter: self interpreterClass
								includeAPIMethods: false
								initializeClasses: false)].

	^cg