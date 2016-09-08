process primitive support
ownerIndexOfThreadId: threadId
	^(objectMemory isIntegerObject: threadId)
		ifTrue: [(objectMemory integerValueOf: threadId) >> 1 bitAnd: ThreadIdMask]
		ifFalse: [0]