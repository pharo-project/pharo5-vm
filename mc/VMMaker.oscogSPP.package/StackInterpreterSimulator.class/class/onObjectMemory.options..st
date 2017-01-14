instance creation
onObjectMemory: anObjectMemory options: optionsDictionaryOrArray
	| simulatorClass |
	^self == StackInterpreterSimulator
		ifTrue:
			[simulatorClass := SmalltalkImage current endianness == #big
								ifTrue: [self notYetImplemented"StackInterpreterSimulatorMSB"]
								ifFalse: [StackInterpreterSimulatorLSB].
			simulatorClass initializeWithOptions: optionsDictionaryOrArray
				objectMemoryClass: (anObjectMemory ifNotNil: [anObjectMemory class]).
			 simulatorClass
				onObjectMemory: (anObjectMemory ifNil:
										[self objectMemoryClass simulatorClass new])
				options: optionsDictionaryOrArray]
		ifFalse: [super basicNew objectMemory: anObjectMemory; initialize]