configurations
generateSqueakStackVM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(FailImbalancedPrimitives false)
		to: (FileDirectory default directoryNamed: self sourceTree, '/stacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()