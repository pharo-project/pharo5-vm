configurations
generateNewspeakSpurStackVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		with: #(	ObjectMemory Spur32BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				FailImbalancedPrimitives false)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspurstacksrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()