decoding
interpretNextInstructionFor: client
	joins at: pc put: stackp.
	^self interpretNextNewspeakInstructionFor: client