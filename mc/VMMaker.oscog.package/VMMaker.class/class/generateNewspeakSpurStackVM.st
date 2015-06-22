configurations
generateNewspeakSpurStackVM
	"No primitives since we can use those from the Cog Newspeak VM"
	^VMMaker
		generate: StackInterpreter
		with: #(	ObjectMemory Spur32BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				FailImbalancedPrimitives false
				EnforceAccessControl true)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsspurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()