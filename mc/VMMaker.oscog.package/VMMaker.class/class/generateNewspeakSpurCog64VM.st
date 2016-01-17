configurations
generateNewspeakSpurCog64VM
	"No primitives since we can use those for the Spur Cog Newspeak VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur64BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				EnforceAccessControl true)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspur64src') fullName
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms') fullName
		including:#()
