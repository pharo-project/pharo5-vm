initialization
initializeWithOptions: optionsDictionaryOrArray
	"Initialize the receiver, typically initializing class variables. Initialize any class variables
	 whose names occur in optionsDictionary with the corresponding values there-in."
	| optionsDictionary |
	optionsDictionary := optionsDictionaryOrArray isArray
							ifTrue: [Dictionary newFromPairs: optionsDictionaryOrArray]
							ifFalse: [optionsDictionaryOrArray].
	"This is necessary.  e.g. if the receiver is CoInterpreterPrimitives,
	 it is still necessary to set the options in CoInterpreter.  Otherwise,
	 some class in the chain may have stale options, and when building
	 the code generator, a stale ancilliary class may be computed."
	(self withAllSuperclasses copyUpThrough: VMClass) do:
		[:class|
		class initializationOptions: optionsDictionary].

	ExpensiveAsserts := optionsDictionary at: #ExpensiveAsserts ifAbsent: [false]