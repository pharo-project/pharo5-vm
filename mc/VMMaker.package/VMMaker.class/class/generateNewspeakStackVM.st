configurations
generateNewspeakStackVM
	"No primitives since we can use those for the Cog Newspeak VM"
	^VMMaker
		generate: StackInterpreter
		with: #(NewspeakVM true MULTIPLEBYTECODESETS true)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsstacksrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including: #()