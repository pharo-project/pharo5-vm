configurations
generateSqueakSpurCogSista64VM
	^VMMaker
		generate: CoInterpreter
		and: SistaCogit
		with: #(	SistaVM true
				ObjectMemory Spur64BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spursista64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()