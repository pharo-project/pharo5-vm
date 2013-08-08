configurations
generateSqueakStackVM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: StackInterpreter
		to: 'oscogvm/stacksrc' asFileReference fullName
		platformDir: 'oscogvm/platforms' asFileReference fullName
		excluding: (InterpreterPlugin withAllSubclasses collect: [:ea| ea name])