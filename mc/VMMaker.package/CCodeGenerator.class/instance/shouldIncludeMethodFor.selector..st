utilities
shouldIncludeMethodFor: aClass selector: selector
	"Answer whether a method shoud be translated.  Process optional methods by
	 interpreting the argument to the option: pragma as either a Cogit class name
	 or a class variable name or a variable name in VMBasicConstants.  Exclude
	 methods with the doNotGenerate pragma."
	(aClass >> selector pragmaAt: #option:) ifNotNil:
		[:pragma| | key |
		key := pragma argumentAt: 1.
		vmMaker ifNotNil:
			[vmMaker cogitClassName ifNotNil:
				[(Cogit withAllSubclasses anySatisfy: [:c| c name = key]) ifTrue:
					[| cogitClass optionClass |
					 cogitClass := Smalltalk classNamed: vmMaker cogitClassName.
					 optionClass := Smalltalk classNamed: key.
					 ^cogitClass includesBehavior: optionClass]].
			((vmClass
				ifNotNil: [vmClass initializationOptions]
				ifNil: [vmMaker options]) at: key ifAbsent: [false]) ifNotNil:
				[:option| option ~~ false ifTrue: [^true]].
		(aClass bindingOf: key) ifNotNil:
			[:binding|
			binding value ~~ false ifTrue: [^true]].
		(VMBasicConstants bindingOf: key) ifNotNil:
			[:binding|
			binding value ~~ false ifTrue: [^true]]].
		^false].
	^(aClass >> selector pragmaAt: #doNotGenerate) isNil