control primitives
primitivePerformWithArgs
	self primitiveObject: (self stackValue: 2)
		perform: (self stackValue: 1)
		withArguments: self stackTop
		lookedUpIn: nil