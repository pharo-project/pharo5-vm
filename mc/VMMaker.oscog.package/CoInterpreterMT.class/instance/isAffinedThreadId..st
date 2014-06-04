process primitive support
isAffinedThreadId: threadId
	^(objectMemory isIntegerObject: threadId)
	  and: [((objectMemory integerValueOf: threadId) bitAnd: 1) = 0]