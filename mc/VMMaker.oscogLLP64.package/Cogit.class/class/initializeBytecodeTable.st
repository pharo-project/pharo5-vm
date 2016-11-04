class initialization
initializeBytecodeTable
	"SimpleStackBasedCogit initializeBytecodeTableWith: Dictionary new"
	"StackToRegisterMappingCogit initializeBytecodeTableWith: Dictionary new"

	| initializer |
	BytecodeSetHasDirectedSuperSend := BytecodeSetHasExtensions := false.
	initializer := initializationOptions
					at: #bytecodeTableInitializer
					ifAbsent:
						[NewspeakVM
							ifTrue:
								[MULTIPLEBYTECODESETS
									ifTrue: [#initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid]
									ifFalse: [#initializeBytecodeTableForNewspeakV4]]
							ifFalse:
								[#initializeBytecodeTableForSqueakV3PlusClosures]].
	"Now make sure all classes in the hierarchy have initialized to the same bytecode table."
	(self withAllSuperclasses copyUpTo: Cogit) reverseDo: "i.e. exclude Cogit"
		[:cogitClass|
		 cogitClass perform: initializer]