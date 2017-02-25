decoding
interpretNextInstructionFor: client
	(deadCode and: [(joins at: pc) notNil]) ifTrue:
		[deadCode := false].
	joins at: pc put: stackp.
	^encoderClass
		ifNil: [super interpretNextInstructionFor: client]
		ifNotNil: [encoderClass interpretNextInstructionFor: client in: self]