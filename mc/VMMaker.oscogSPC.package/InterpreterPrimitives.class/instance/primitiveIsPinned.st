memory space primitives
primitiveIsPinned
	"Answer if the receiver is pinned, i.e. immobile."
	<option: #SpurObjectMemory>
	| obj |
	obj := self stackTop.
	((objectMemory isImmediate: obj)
	 or: [objectMemory isForwarded: obj]) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	self pop: argumentCount + 1
		thenPushBool: (objectMemory isPinned: obj)