object access primitives
primitiveBehaviorHash
	| hashOrError |
	self assert: (objectMemory isIntegerObject: self stackTop) not.
	hashOrError := objectMemory ensureBehaviorHash: self stackTop.
	hashOrError >= 0
		ifTrue: [self pop: 1 thenPushInteger: hashOrError]
		ifFalse: [self primitiveFailFor: hashOrError negated]