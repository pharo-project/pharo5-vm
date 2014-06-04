memory space primitives
primitiveIsPinned
	"Answer if the receiver is pinned, i.e. immobile."
	| obj |
	obj := self stackTop.
	((objectMemory isImmediate: obj)
	 or: [objectMemory isForwarded: obj]) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	self pop: argumentCount - 1.
	self stackTopPut:
			(objectMemory hasSpurMemoryManagerAPI
				ifTrue: [objectMemory booleanObjectOf: (objectMemory isPinned: obj)]
				ifFalse: [objectMemory falseObject])