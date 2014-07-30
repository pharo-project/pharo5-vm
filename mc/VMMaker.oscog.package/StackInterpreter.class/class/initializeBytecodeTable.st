initialization
initializeBytecodeTable
	"StackInterpreter initializeBytecodeTable"

	(initializationOptions at: #bytecodeTableInitializer ifAbsent: nil) ifNotNil:
		[:initalizer| ^self perform: initalizer].

	NewspeakVM ifTrue:
		[^MULTIPLEBYTECODESETS
			ifTrue: [self initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid]
			ifFalse: [self initializeBytecodeTableForNewspeakV3PlusClosures]].

	^self initializeBytecodeTableForSqueakV3PlusClosures