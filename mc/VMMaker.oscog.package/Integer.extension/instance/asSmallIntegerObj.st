*VMMaker-interpreter simulator
asSmallIntegerObj
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| simulator getInterpreter integerObjectOf: self]
		ifNil: [self]