arithmetic integer primitives
primitiveMakePoint
	<inline: false>
	| rcvr pt |
	rcvr := self stackValue: 1.
	((objectMemory isIntegerObject: rcvr) or: [objectMemory isFloatObject: rcvr]) ifFalse:
		[^self primitiveFail].
	pt := objectMemory eeInstantiateSmallClass: (objectMemory splObj: ClassPoint) numSlots: YIndex + 1.
	objectMemory
		storePointerUnchecked: XIndex ofObject: pt withValue: rcvr;
		storePointerUnchecked: YIndex ofObject: pt withValue: self stackTop.
	self pop: 2 thenPush: pt