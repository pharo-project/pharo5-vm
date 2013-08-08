instance creation
new
	^self == CogVMSimulator
		ifTrue: [SmalltalkImage current endianness == #big
				ifTrue: [self notYetImplemented]
				ifFalse: [CogVMSimulatorLSB new]]
		ifFalse: [super new]