configurations
generateSqueakStackVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		to: (FileDirectory default directoryNamed: self sourceTree, '/stacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()