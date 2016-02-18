initialization
initializeBytecodeTable
	"StackInterpreter initializeBytecodeTable"

	BytecodeSetHasDirectedSuperSend := false.

	(initializationOptions at: #bytecodeTableInitializer ifAbsent: nil) ifNotNil:
		[:initalizer| ^self perform: initalizer].

	NewspeakVM ifTrue:
		[^MULTIPLEBYTECODESETS
			ifTrue: [self initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid]
			ifFalse: [self initializeBytecodeTableForNewspeakV4]].

	^self initializeBytecodeTableForSqueakV3PlusClosures