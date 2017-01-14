arithmetic float primitives
primitiveFloatGreaterOrEqual
	| aBool |
	aBool := self primitiveFloatGreaterOrEqual: (self stackValue: 1) toArg: self stackTop.
	self successful ifTrue: [self pop: 2 thenPushBool: aBool]