*VMMaker-interpreter simulator
asSmallIntegerObj
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter| interpreter integerObjectOf: self]
		ifNil: [self]