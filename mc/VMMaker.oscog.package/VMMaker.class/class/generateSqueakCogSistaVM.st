configurations
generateSqueakCogSistaVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: SistaStackToRegisterMappingCogit
		to: (FileDirectory default pathFromURI: self sourceTree, '/sistasrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()