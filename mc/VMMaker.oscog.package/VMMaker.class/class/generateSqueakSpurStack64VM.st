configurations
generateSqueakSpurStack64VM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur64BitMemoryManager)
		to: (FileDirectory default directoryNamed: self sourceTree, '/spurstack64src') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()