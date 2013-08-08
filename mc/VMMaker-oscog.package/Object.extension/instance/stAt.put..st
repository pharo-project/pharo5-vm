*VMMaker-translation support
stAt: index put: value
	"Simulation of generateStAtPut:on:indent:"
	
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| simulator getInterpreter stObject: self at: index put: value]
		ifNil: [self at: index put: value]