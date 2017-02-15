configurations
generateSqueakSpurLowcodeStack64VM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur64BitMemoryManager
				SistaVM true
        			LowcodeVM true
				FailImbalancedPrimitives false
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurlowcodestack64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()