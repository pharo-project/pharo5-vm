generate sources
buildCodeGeneratorForCogit: cogitClass includeAPIMethods: getAPIMethods initializeClasses: initializeClasses
	"Answer the code generator for translating the cogit."

	| cg aClass cogitClasses apicg |
	cg := self createCogitCodeGenerator.

	cg vmClass: cogitClass.
	initializeClasses ifTrue:
		[{ cogitClass. self interpreterClass. self interpreterClass objectMemoryClass } do:
			[:cgc|
			(cgc respondsTo: #initializeWithOptions:)
				ifTrue: [cgc initializeWithOptions: optionsDictionary]
				ifFalse: [cgc initialize]]].

	cogitClasses := OrderedCollection new.
	aClass := cogitClass.
	[cogitClasses addFirst: aClass.
	 aClass ~~ Cogit
	 and: [aClass inheritsFrom: Cogit]] whileTrue:
		[aClass := aClass superclass].
	cogitClasses addFirst: VMClass.
	cogitClasses addAllLast: ((cogitClass ancilliaryClasses: optionsDictionary) reject: [:class| class isStructClass]).
	cogitClasses do: [:cgc| cg addClass: cgc].
	cg addStructClasses: (cg structClassesForTranslationClasses: cogitClasses).

	getAPIMethods ifTrue:
		[apicg := self
					buildCodeGeneratorForInterpreter: self interpreterClass
					includeAPIMethods: false
					initializeClasses: false.
		 cg apiMethods: apicg selectAPIMethods].

	cg removeConstant: #VMBIGENDIAN. "this should be defined in platforms/??/vm/sqConfig.h"

	^cg