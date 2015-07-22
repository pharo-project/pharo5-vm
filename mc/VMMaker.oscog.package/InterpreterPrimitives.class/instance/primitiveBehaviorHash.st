object access primitives
primitiveBehaviorHash
	| hashOrError |
	NewspeakVM ifTrue: "For the mirror prims check that the class obj is actually a valid class."
		[argumentCount > 0 ifTrue:
			[((objectMemory isNonImmediate: self stackTop)
			  and: [self objCouldBeClassObj: self stackTop]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument]]].
	self assert: ((objectMemory isNonImmediate: self stackTop)
				  and: [self addressCouldBeClassObj: self stackTop]).
	hashOrError := objectMemory ensureBehaviorHash: self stackTop.
	hashOrError >= 0
		ifTrue: [self pop: argumentCount + 1 thenPushInteger: hashOrError]
		ifFalse: [self primitiveFailFor: hashOrError negated]