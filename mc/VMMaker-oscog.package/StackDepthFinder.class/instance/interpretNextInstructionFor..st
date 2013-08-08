decoding
interpretNextInstructionFor: client
	joins at: pc put: stackp.
	^super interpretNextInstructionFor: client