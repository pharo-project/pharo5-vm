configurations
generateGlueSpurStackVM
	"No primitives since we can use those from the Cog Spur Newspeak VM"
	^VMMaker
		generate: StackInterpreter
		with: #(	ObjectMemory Spur32BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				FailImbalancedPrimitives false
				EnforceAccessControl false)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsnacspurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()