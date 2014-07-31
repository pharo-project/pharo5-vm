configurations
generateSqueakCogSistaVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: SistaStackToRegisterMappingCogit
		with: #(	SistaVM true
				MULTIPLEBYTECODESETS true
				bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid)
		to: (FileDirectory default pathFromURI: self sourceTree, '/sistasrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()