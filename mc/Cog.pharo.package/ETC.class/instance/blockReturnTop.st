instruction decoding
blockReturnTop
	"Return Top Of Stack bytecode."
	currentContext pop.
	scanner pc < blockEnd
		ifTrue: [self doJoin]
		ifFalse: [currentContext := contextStack removeLast.
				blockEnd := blockEndStack removeLast]