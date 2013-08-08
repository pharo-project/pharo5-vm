instance creation
new
	^ self == NewspeakInterpreterSimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [NewspeakInterpreterSimulatorMSB new]
				ifFalse: [NewspeakInterpreterSimulatorLSB new]]
		ifFalse: [super new]