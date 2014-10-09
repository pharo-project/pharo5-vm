memory space primitives
primitivePin
	"Pin or unpin the receiver, i.e. make it immobile or mobile, based on the argument.
	 Answer whether the object was already pinned. N.B. pinning does *not* prevent
	 an object from being garbage collected."
	| obj boolean wasPinned |
	objectMemory hasSpurMemoryManagerAPI ifFalse:
		[^self primitiveFailFor: PrimErrUnsupported].

	obj := self stackValue: 1.
	((objectMemory isImmediate: obj)
	 or: [(objectMemory isForwarded: obj)
	 or: [(objectMemory isContext: obj)
		and: [self isStillMarriedContext: obj]]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	boolean := self stackTop.
	(boolean = objectMemory falseObject
	 or: [boolean = objectMemory trueObject]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].

	(objectMemory isPinned: obj)
		ifTrue:
			[wasPinned := objectMemory trueObject.
			 objectMemory setIsPinnedOf: obj to: boolean = objectMemory trueObject]
		ifFalse:
			[wasPinned := objectMemory falseObject.
			 (boolean = objectMemory trueObject
			  and: [objectMemory pinObject: obj]) = 0 ifTrue:
				[^self primitiveFailFor: PrimErrNoMemory]].
	
	self pop: argumentCount - 1 thenPush: wasPinned