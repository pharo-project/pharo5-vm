configurations
generateSqueakSpurStackVMWithImmutability
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur32BitMemoryManager
				FailImbalancedPrimitives false
				IMMUTABILITY true)
		to: (FileDirectory default directoryNamed: self sourceTree, '/spurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()