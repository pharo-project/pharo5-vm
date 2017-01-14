arithmetic float primitives
primitiveFloatEqual
	| aBool |
	aBool := self primitiveFloatEqual: (self stackValue: 1) toArg: self stackTop.
	self successful ifTrue:
		[self pop: 2 thenPushBool: aBool]