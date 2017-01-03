configurations
generateSqueakSpurLowcodeCogVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(ObjectMemory Spur32BitCoMemoryManager
				SistaVM true
        			LowcodeVM true
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurlowcodesrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()