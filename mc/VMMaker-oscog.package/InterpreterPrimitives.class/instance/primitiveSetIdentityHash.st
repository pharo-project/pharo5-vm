object access primitives
primitiveSetIdentityHash
	| hash oldHash thisReceiver |
	hash := self stackIntegerValue: 0.
	thisReceiver := self stackObjectValue: 1.
	self successful ifTrue:
		[oldHash := objectMemory hashBitsOf: thisReceiver.
		 objectMemory setHashBitsOf: thisReceiver to: hash.
		 self pop: argumentCount + 1 thenPushInteger: oldHash]