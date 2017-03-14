configurations
generateSqueakSpurStackSistaVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(SistaVM true
				ObjectMemory Spur32BitMemoryManager
				FailImbalancedPrimitives false
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spursistastacksrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()