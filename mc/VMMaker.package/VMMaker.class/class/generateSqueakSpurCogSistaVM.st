configurations
generateSqueakSpurCogSistaVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: SistaStackToRegisterMappingCogit
		with: #(ObjectMemory Spur32BitCoMemoryManager)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spursistasrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()