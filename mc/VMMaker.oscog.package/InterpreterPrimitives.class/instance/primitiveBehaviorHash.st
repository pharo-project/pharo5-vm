object access primitives
primitiveBehaviorHash
	| hashOrError |
	argumentCount > 0
		ifTrue:
			[((objectMemory isNonImmediate: self stackTop)
			  and: [self addressCouldBeClassObj: self stackTop]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument]]
		ifFalse:
			[self assert: ((objectMemory isNonImmediate: self stackTop)
						  and: [self addressCouldBeClassObj: self stackTop])].
	hashOrError := objectMemory ensureBehaviorHash: self stackTop.
	hashOrError >= 0
		ifTrue: [self pop: argumentCount + 1 thenPushInteger: hashOrError]
		ifFalse: [self primitiveFailFor: hashOrError negated]