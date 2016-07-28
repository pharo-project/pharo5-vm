configurations
generateSqueakStackVM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(FailImbalancedPrimitives false)
		to: (FileDirectory default pathFromURI: self sourceTree, '/stacksrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()