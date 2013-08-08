instance creation
new
	^ self == StackInterpreterSimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [self notYetImplemented"StackInterpreterSimulatorMSB new"]
				ifFalse: [StackInterpreterSimulatorLSB new]]
		ifFalse: [super new]