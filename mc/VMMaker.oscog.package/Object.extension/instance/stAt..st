*VMMaker-translation support
stAt: index
	"Simulation of generateStAt:on:indent:"
	
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| simulator stObject: self at: index]
		ifNil: [self at: index]