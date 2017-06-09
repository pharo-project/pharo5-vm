arithmetic integer primitives
primitiveMakePoint
	<inline: false>
	| rcvr arg pt |
	rcvr := self stackValue: 1.
	arg := self stackTop.
	(objectMemory isFloatOrInt: arg) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	pt := objectMemory eeInstantiateSmallClass: (objectMemory splObj: ClassPoint) numSlots: YIndex + 1.
	objectMemory "No need to check since new object is always new."
		storePointerUnchecked: XIndex ofObject: pt withValue: rcvr;
		storePointerUnchecked: YIndex ofObject: pt withValue: arg.
	self pop: 2 thenPush: pt