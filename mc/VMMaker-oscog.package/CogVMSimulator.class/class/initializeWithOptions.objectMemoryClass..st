class initialization
initializeWithOptions: optionsDictionaryOrArray objectMemoryClass: objectMemoryClassOrNil
	"The relevant ObjectMemory, Interpreter and Cogit classes must be initialized in order.
	 This happens notionally every time we start the simulator,
	 but in fact happens when ever we instantiate a simulator."
	| optionsDictionary cogitClassOrName |
	optionsDictionary := optionsDictionaryOrArray isArray
							ifTrue: [Dictionary newFromPairs: optionsDictionaryOrArray]
							ifFalse: [optionsDictionaryOrArray].
	(objectMemoryClassOrNil ifNil: [self objectMemoryClass])
		initializeWithOptions: optionsDictionary.

	((optionsDictionary at: #COGMTVM ifAbsent: [false])
			ifTrue: [CoInterpreterMT]
			ifFalse: [CoInterpreter])
		initializeWithOptions: optionsDictionary.

	(optionsDictionary includesKey: #Cogit) ifTrue:
		[cogitClassOrName := optionsDictionary at: #Cogit.
		 cogitClassOrName isSymbol ifTrue:
			[cogitClassOrName := Smalltalk classNamed: cogitClassOrName].
		CoInterpreter classPool at: #CogitClass put: cogitClassOrName].

	(self cogitClass withAllSuperclasses copyUpTo: Cogit) reverseDo:
		[:c| c initializeWithOptions: optionsDictionary]