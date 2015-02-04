class initialization
initializeBytecodeTable
	"SimpleStackBasedCogit initializeBytecodeTableWith: Dictionary new"
	"StackToRegisterMappingCogit initializeBytecodeTableWith: Dictionary new"

	(initializationOptions at: #bytecodeTableInitializer ifAbsent: nil) ifNotNil:
		[:initalizer| ^self perform: initalizer].

	NewspeakVM ifTrue:
		[^(initializationOptions at: #SpurObjectMemory ifAbsent: false)
			ifTrue:
				[MULTIPLEBYTECODESETS
					ifTrue: [self initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid]
					ifFalse: [self initializeBytecodeTableForNewspeakV4]]
			ifFalse:
				[MULTIPLEBYTECODESETS
					ifTrue: [self initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid]
					ifFalse: [self initializeBytecodeTableForNewspeakV3PlusClosures]]].
	^self initializeBytecodeTableForSqueakV3PlusClosures