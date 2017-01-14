configurations
generateSqueakSpurRegisterCogVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: RegisterAllocatingCogit
		with: #(ObjectMemory Spur32BitCoMemoryManager)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurregsrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()