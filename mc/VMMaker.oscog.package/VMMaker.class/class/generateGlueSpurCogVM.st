configurations
generateGlueSpurCogVM
	"No primitives since we can use those from the Cog Spur Newspeak VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur32BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				EnforceAccessControl false)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsnacspursrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()