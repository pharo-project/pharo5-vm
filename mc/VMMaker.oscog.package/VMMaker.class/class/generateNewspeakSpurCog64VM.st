configurations
generateNewspeakSpurCog64VM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur64BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsspur64src') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including:#()
