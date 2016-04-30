utilities
optionIsTrue: pragma in: aClass
	"Answer whether an option: or notOption: pragma is true in the context of aClass.
	 The argument to the option: pragma is interpreted as either a Cogit class name
	 or a class variable name or a variable name in VMBasicConstants."
	| key |
	key := pragma argumentAt: 1.

	"If the option is one to be defined at compile time we'll generate a
	 conditional around its declaration and definition."
	((vmClass ifNil: [VMBasicConstants]) defineAtCompileTime: key) ifTrue:
		[^true].

	"If the option is the name of a subclass of Cogit, include it if it inherits from the Cogit class."
	(Smalltalk classNamed: key) ifNotNil:
		[:optionClass|
		 aClass cogitClass ifNotNil:
			[:cogitClass|
			 (optionClass includesBehavior: Cogit) ifTrue:
				[^cogitClass includesBehavior: optionClass]].
		 aClass objectMemoryClass ifNotNil:
			[:objectMemoryClass|
			 ((optionClass includesBehavior: ObjectMemory)
			   or: [optionClass includesBehavior: SpurMemoryManager]) ifTrue:
				[^objectMemoryClass includesBehavior: optionClass]]].
	"Lookup options in options, class variables of the defining class, VMBasicConstants, the interpreterClass and the objectMemoryClass"
	{aClass initializationOptions.
	  aClass.
	  VMBasicConstants.
	  aClass interpreterClass.
	  aClass objectMemoryClass} do:
		[:scopeOrNil|
		 scopeOrNil ifNotNil:
			[:scope|
			 (scope bindingOf: key) ifNotNil:
				[:binding|
				binding value ~~ false ifTrue: [^true]]]].
	^false