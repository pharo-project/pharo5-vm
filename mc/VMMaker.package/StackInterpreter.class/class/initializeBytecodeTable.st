initialization
initializeBytecodeTable
	"StackInterpreter initializeBytecodeTable"

	NewspeakVM ifTrue:
		[^MULTIPLEBYTECODESETS
			ifTrue: [self initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid]
			ifFalse: [self initializeBytecodeTableForNewspeakV3PlusClosures]].

	^self initializeBytecodeTableForSqueakV3PlusClosures