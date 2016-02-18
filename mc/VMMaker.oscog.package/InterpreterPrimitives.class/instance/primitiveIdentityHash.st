object access primitives
primitiveIdentityHash
	| thisReceiver |
	thisReceiver := self stackTop.
	((objectMemory isImmediate: thisReceiver)
	 or: [argumentCount > 0
		 and: [objectMemory isForwarded: thisReceiver]])
		ifTrue: [self primitiveFail]
		ifFalse: [self pop: argumentCount + 1
					thenPushInteger: (objectMemory hashBitsOf: thisReceiver)]