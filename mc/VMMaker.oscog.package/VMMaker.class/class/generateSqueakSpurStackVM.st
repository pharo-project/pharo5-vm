configurations
generateSqueakSpurStackVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur32BitMemoryManager)
		to: (FileDirectory default directoryNamed: self sourceTree, '/spurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()