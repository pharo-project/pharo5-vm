configurations
generateSqueakSpurStackVM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur32BitMemoryManager
				FailImbalancedPrimitives false
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurstacksrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()