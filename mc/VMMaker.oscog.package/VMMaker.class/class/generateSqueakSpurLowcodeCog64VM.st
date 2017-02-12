configurations
generateSqueakSpurLowcodeCog64VM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(ObjectMemory Spur64BitCoMemoryManager
				SistaVM true
        			LowcodeVM true
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurlowcode64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()