*VMMaker-interpreter simulator
asBooleanObj
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter| interpreter booleanObjectOf: self]
		ifNil: [self]