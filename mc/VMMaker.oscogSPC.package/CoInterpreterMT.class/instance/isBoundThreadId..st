process primitive support
isBoundThreadId: threadId
	^(objectMemory isIntegerObject: threadId)
	  and: [((objectMemory integerValueOf: threadId) bitAnd: 1) = 1]