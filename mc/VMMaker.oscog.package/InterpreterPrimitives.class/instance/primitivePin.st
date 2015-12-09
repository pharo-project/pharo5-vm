memory space primitives
primitivePin
	"Pin or unpin the receiver, i.e. make it immobile or mobile, based on the argument.
	 Answer whether the object was already pinned. N.B. pinning does *not* prevent
	 an object from being garbage collected."
	<option: #SpurObjectMemory>
	| obj boolean wasPinned |

	obj := self stackValue: 1.
	((objectMemory isImmediate: obj)
	 or: [objectMemory isForwarded: obj]) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].

	boolean := self stackTop.
	(boolean = objectMemory falseObject
	 or: [boolean = objectMemory trueObject]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].

	(objectMemory isPinned: obj)
		ifTrue:
			[wasPinned := objectMemory trueObject.
			 boolean ~= wasPinned ifTrue:
				[objectMemory setIsPinnedOf: obj to: false]]
		ifFalse:
			[wasPinned := objectMemory falseObject.
			 (boolean ~= wasPinned
			  and: [(objectMemory pinObject: obj) = 0]) ifTrue:
				[^self primitiveFailFor: PrimErrNoMemory]].
	
	self pop: argumentCount + 1 thenPush: wasPinned