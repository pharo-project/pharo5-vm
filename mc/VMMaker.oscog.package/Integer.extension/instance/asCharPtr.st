*VMMaker-interpreter simulator
asCharPtr
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| self coerceTo: #'char *' sim: simulator getInterpreter]
		ifNil: [self]