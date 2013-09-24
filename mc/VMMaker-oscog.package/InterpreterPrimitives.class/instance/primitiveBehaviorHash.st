object access primitives
primitiveBehaviorHash
	| hashOrError |
	self assert: ((objectMemory isNonImmediate: self stackTop)
				 and: [self addressCouldBeClassObj: self stackTop]).
	hashOrError := objectMemory ensureBehaviorHash: self stackTop.
	hashOrError >= 0
		ifTrue: [self pop: argumentCount + 1 thenPushInteger: hashOrError]
		ifFalse: [self primitiveFailFor: hashOrError negated]