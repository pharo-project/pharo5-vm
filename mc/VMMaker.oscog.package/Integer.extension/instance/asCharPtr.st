*VMMaker-interpreter simulator
asCharPtr
	^(Notification new tag: #getSimulator; signal)
		ifNotNil: [:simulator| | interpreter |
				interpreter := simulator getInterpreter.
				(interpreter firstIndexableField: self) asInteger
					coerceTo: #'char *'
					sim: interpreter]
		ifNil: [self]