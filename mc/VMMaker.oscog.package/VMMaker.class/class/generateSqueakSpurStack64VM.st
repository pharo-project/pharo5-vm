configurations
generateSqueakSpurStack64VM
	"No primitives since we can use those from the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(ObjectMemory Spur64BitMemoryManager
				FailImbalancedPrimitives false)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spurstack64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()