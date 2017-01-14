instance creation
new
	^self == NewCoObjectMemorySimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [NewCoObjectMemorySimulatorMSB new]
				ifFalse: [NewCoObjectMemorySimulatorLSB new]]
		ifFalse: [super new]