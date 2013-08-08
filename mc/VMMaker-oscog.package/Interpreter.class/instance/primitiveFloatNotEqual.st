arithmetic float primitives
primitiveFloatNotEqual
	| aBool |
	aBool := self primitiveFloatEqual: (self stackValue: 1) toArg: self stackTop.
	successFlag ifTrue: [self pop: 2. self pushBool: aBool not].
