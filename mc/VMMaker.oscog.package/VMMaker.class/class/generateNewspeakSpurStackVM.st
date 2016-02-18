configurations
generateNewspeakSpurStackVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(	ObjectMemory Spur32BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				FailImbalancedPrimitives false)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsspurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()