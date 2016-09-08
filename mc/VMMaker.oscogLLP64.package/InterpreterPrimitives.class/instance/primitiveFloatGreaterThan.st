arithmetic float primitives
primitiveFloatGreaterThan
	| aBool |
	aBool := self primitiveFloatGreater: (self stackValue: 1) thanArg: self stackTop.
	self successful ifTrue:
		[self pop: 2 thenPushBool: aBool]