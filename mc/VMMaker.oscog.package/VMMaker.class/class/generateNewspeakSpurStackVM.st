configurations
generateNewspeakSpurStackVM
	"No primitives since we can use those for the Cog Newspeak VM"
	^VMMaker
		generate: StackInterpreter
		with: #(	ObjectMemory Spur32BitMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true)
		to: (FileDirectory default directoryNamed: self sourceTree, '/nsspurstacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: self sourceTree, '/platforms') fullName
		including: #()