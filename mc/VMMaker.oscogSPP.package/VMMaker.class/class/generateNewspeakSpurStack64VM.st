configurations
generateNewspeakSpurStack64VM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #( ObjectMemory Spur64BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				FailImbalancedPrimitives false)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspurstack64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()