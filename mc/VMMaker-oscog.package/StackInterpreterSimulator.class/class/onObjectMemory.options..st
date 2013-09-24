instance creation
onObjectMemory: anObjectMemory options: optionsDictionaryOrArray
	^self == StackInterpreterSimulator
		ifTrue:
			[self initializeWithOptions: optionsDictionaryOrArray
				objectMemoryClass: (anObjectMemory ifNotNil: [anObjectMemory class]).
			 SmalltalkImage current endianness == #big
				ifTrue: [self notYetImplemented"StackInterpreterSimulatorMSB onObjectMemory: anObjectMemory"]
				ifFalse: [StackInterpreterSimulatorLSB onObjectMemory: anObjectMemory]]
		ifFalse: [super basicNew objectMemory: anObjectMemory; initialize]