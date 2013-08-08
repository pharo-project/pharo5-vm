arithmetic float primitives
primitiveFloatGreaterThan
	| aBool |
	aBool := self primitiveFloatGreater: (self stackValue: 1) thanArg: self stackTop.
	successFlag ifTrue: [self pop: 2. self pushBool: aBool].
