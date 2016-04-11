object access primitives
primitiveSetOrHasIdentityHash
	| hash oldHash thisReceiver isReceiverAClass |
	argumentCount = 0 ifTrue:
		[| hasHash |
		 hasHash := (objectMemory isNonImmediate: self stackTop)
						and: [objectMemory hasIdentityHash: self stackTop].
		 self pop: argumentCount + 1 thenPushBool: hasHash.
		 ^self].
	argumentCount = 2 
		ifTrue: 
			[isReceiverAClass := self booleanValueOf: self stackTop.
			self successful ifFalse: [self primitiveFailFor: PrimErrBadArgument] ]
		ifFalse: [isReceiverAClass := false].
	hash := self stackIntegerValue: argumentCount - 1.
	thisReceiver := self stackObjectValue: argumentCount.
	self successful ifTrue:
		[oldHash := objectMemory hashBitsOf: thisReceiver.
		 objectMemory setHashBitsOf: thisReceiver to: hash.
		(isReceiverAClass and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
				[objectMemory classAtIndex: hash put: thisReceiver.
				"next line figures out if the index is anbiguous and fix all the instances if needed"
				objectMemory allInstancesOf: thisReceiver].
		 self pop: argumentCount + 1 thenPushInteger: oldHash]