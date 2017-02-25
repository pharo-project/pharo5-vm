instance creation
new
	^self == NewObjectMemorySimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [NewObjectMemorySimulatorMSB new]
				ifFalse: [NewObjectMemorySimulatorLSB new]]
		ifFalse: [super new]