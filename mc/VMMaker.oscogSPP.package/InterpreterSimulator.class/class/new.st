instance creation
new
	^ self == InterpreterSimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [InterpreterSimulatorMSB new]
				ifFalse: [InterpreterSimulatorLSB new]]
		ifFalse: [super new]