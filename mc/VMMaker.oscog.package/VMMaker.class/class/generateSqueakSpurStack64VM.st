configurations
generateSqueakSpurStack64VM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur64BitMemoryManager
				FailImbalancedPrimitives false)
		to: (FileDirectory default directoryNamed: self sourceTree, '/spurstack64src') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()