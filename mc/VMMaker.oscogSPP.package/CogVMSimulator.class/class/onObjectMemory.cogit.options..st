instance creation
onObjectMemory: anObjectMemory cogit: aCogit options: optionsDictionaryOrArray
	| simulatorClass |
	^self == CogVMSimulator
		ifTrue:
			[simulatorClass := SmalltalkImage current endianness == #big
				ifTrue: [self notYetImplemented]
				ifFalse: [CogVMSimulatorLSB].
			simulatorClass
				initializeWithOptions: optionsDictionaryOrArray
				objectMemoryClass: (anObjectMemory ifNotNil: [anObjectMemory class]).
			 simulatorClass
				onObjectMemory: (anObjectMemory ifNil:
										[self objectMemoryClass simulatorClass new])
				cogit: aCogit
				options: optionsDictionaryOrArray]
		ifFalse:
			[| sim |
			sim := self basicNew.
			sim objectMemory: anObjectMemory.
			sim cogit: aCogit.
			sim initialize.
			COGMTVM ifTrue: "Set via options"
				[sim initializeThreadSupport; initialize].
			sim]