object access primitives
primitiveSetOrHasIdentityHash
	| hash oldHash thisReceiver |
	argumentCount = 0 ifTrue:
		[| hasHash |
		 hasHash := (objectMemory isNonImmediate: self stackTop)
						and: [objectMemory hasIdentityHash: self stackTop].
		 self pop: argumentCount + 1 thenPushBool: hasHash.
		 ^self].
	hash := self stackIntegerValue: 0.
	thisReceiver := self stackObjectValue: 1.
	self successful ifTrue:
		[oldHash := objectMemory hashBitsOf: thisReceiver.
		 objectMemory setHashBitsOf: thisReceiver to: hash.
		 self pop: argumentCount + 1 thenPushInteger: oldHash]