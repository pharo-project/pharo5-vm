*VMMaker-translation support
stAt: index
	"Simulation of generateStAt:on:indent:"
	
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter| interpreter stObject: self at: index]
		ifNil: [self at: index]