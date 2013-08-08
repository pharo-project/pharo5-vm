arithmetic float primitives
primitiveFloatLessOrEqual
	| aBool |
	aBool := self primitiveFloatLessOrEqual: (self stackValue: 1) toArg: self stackTop.
	self successful ifTrue: [self pop: 2 thenPushBool: aBool]