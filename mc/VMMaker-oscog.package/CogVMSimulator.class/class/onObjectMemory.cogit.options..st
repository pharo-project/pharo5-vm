instance creation
onObjectMemory: anObjectMemory cogit: aCogit options: optionsDictionaryOrArray
	^self == CogVMSimulator
		ifTrue:
			[self initializeWithOptions: optionsDictionaryOrArray
				objectMemoryClass: (anObjectMemory ifNotNil: [anObjectMemory class]).
			 SmalltalkImage current endianness == #big
				ifTrue: [self notYetImplemented]
				ifFalse: [CogVMSimulatorLSB onObjectMemory: anObjectMemory cogit: aCogit options: optionsDictionaryOrArray]]
		ifFalse:
			[| sim |
			sim := self basicNew.
			sim objectMemory: anObjectMemory.
			sim cogit: aCogit.
			sim initialize.
			COGMTVM ifTrue: "Set via options"
				[sim initializeThreadSupport; initialize].
			sim]