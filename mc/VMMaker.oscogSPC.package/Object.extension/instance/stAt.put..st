*VMMaker-translation support
stAt: index put: value
	"Simulation of generateStAtPut:on:indent:"
	
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter| interpreter stObject: self at: index put: value]
		ifNil: [self at: index put: value]