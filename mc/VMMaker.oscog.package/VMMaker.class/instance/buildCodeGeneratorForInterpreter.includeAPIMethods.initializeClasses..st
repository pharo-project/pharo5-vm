generate sources
buildCodeGeneratorForInterpreter: interpreterClass includeAPIMethods: getAPIMethods initializeClasses: initializeClasses
	"Answer the code generator for translating the interpreter."

	| cg theClass interpreterClasses apicg |
	interpreterClasses := OrderedCollection new.

	initializeClasses ifTrue:
		[interpreterClass initializeWithOptions: optionsDictionary].

	(cg := self createCodeGenerator) vmClass: interpreterClass.

	theClass := interpreterClass.
	[theClass ~~ VMClass] whileTrue:
		[interpreterClasses addFirst: theClass.
		 theClass := theClass superclass].
	
	cg vmClass objectMemoryClass ifNotNil:
		[:objectMemoryClass|
		theClass := objectMemoryClass.
		[theClass ~~ VMClass] whileTrue:
			[interpreterClasses addFirst: theClass.
			 theClass := theClass superclass]].

	interpreterClasses addFirst: VMClass.
	interpreterClasses addAllLast: (cg nonStructClassesForTranslationClasses: interpreterClasses).

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

	(getAPIMethods
	and: [self interpreterClass needsCogit]) ifTrue:
		[apicg := self
					buildCodeGeneratorForCogit: self cogitClass
					includeAPIMethods: false
					initializeClasses: false.
		 cg apiMethods: apicg selectAPIMethods].

	cg removeConstant: #VMBIGENDIAN. "this should be defined in platforms/??/vm/sqConfig.h"

	^cg