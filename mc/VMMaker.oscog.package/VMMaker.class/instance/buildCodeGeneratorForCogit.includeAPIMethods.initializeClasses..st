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
	cg addStructClasses: (cg structClassesForTranslationClasses: cogitClasses).

	getAPIMethods ifTrue:
		[cg includeAPIFrom: (self
								buildCodeGeneratorForInterpreter: self interpreterClass
								includeAPIMethods: false
								initializeClasses: false)].

	cg
		removeConstant: #VMBIGENDIAN; "this should be defined in platforms/??/vm/sqConfig.h"
		const: #IMMUTABILITY "this can be defined on the C compiler command line."
			declareC: ('#if !defined(IMMUTABILITY)\/* Allow IMMUTABILITY to be overridden on the compiler command line */\# define IMMUTABILITY ', (cg cLiteralFor: false),'\#endif') withCRs.

	^cg