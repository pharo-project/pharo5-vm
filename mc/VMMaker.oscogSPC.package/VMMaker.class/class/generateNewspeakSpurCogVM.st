configurations
generateNewspeakSpurCogVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur32BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspursrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()
