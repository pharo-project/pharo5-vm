configurations
generateSqueakSpurCogSistaVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: SistaCogit
		with: #(	SistaVM true
				ObjectMemory Spur32BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spursistasrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()