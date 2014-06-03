arithmetic float primitives
primitiveFloatLessThan
	| aBool |
	aBool := self primitiveFloatLess: (self stackValue: 1) thanArg: self stackTop.
	self successful ifTrue:
		[self pop: 2 thenPushBool: aBool]