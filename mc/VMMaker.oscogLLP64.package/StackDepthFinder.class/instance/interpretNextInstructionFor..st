decoding
interpretNextInstructionFor: client
	joins at: pc put: stackp.
	^encoderClass
		ifNil: [super interpretNextInstructionFor: client]
		ifNotNil: [encoderClass interpretNextInstructionFor: client in: self]