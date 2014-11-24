utilities
shouldIncludeMethodFor: aClass selector: selector
	"Answer whether a method shoud be translated.  Process optional methods by
	 interpreting the argument to the option: pragma as either a Cogit class name
	 or a class variable name or a variable name in VMBasicConstants.  Exclude
	 methods with the doNotGenerate pragma."
	| pragmas |
	"where is pragmasAt: ??"
	(pragmas := (aClass >> selector) pragmas select: [:p| p keyword == #option:]) notEmpty ifTrue:
		[pragmas do:
			[:pragma| | key |
			 key := pragma argumentAt: 1.
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
						binding value ~~ false ifTrue: [^true]]]]].
		^false].
	^(aClass >> selector pragmaAt: #doNotGenerate) isNil