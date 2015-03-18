configurations
generateSqueakSpurCogVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur32BitCoMemoryManager
				ISA IA32)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spursrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()