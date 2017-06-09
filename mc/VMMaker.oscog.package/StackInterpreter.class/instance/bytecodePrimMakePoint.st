common selector sends
bytecodePrimMakePoint
	"Inline primitiveMakePoint for the benefit of the interpreter. Externalizing the
	 sp & fp, then internalizing and testign for primitive failure add much overhead.
	 So simply inline the relatively small ammount of code directly."
	| rcvr arg pt |
	rcvr := self internalStackValue: 1.
	arg := self internalStackTop.
	((objectMemory isFloatOrInt: rcvr)
	 and: [objectMemory isFloatOrInt: arg]) ifTrue:
		[pt := objectMemory eeInstantiateSmallClass: (objectMemory splObj: ClassPoint) numSlots: YIndex + 1.
		 objectMemory "No need to check since new object is always new."
			storePointerUnchecked: XIndex ofObject: pt withValue: rcvr;
			storePointerUnchecked: YIndex ofObject: pt withValue: arg.
		 self internalPop: 2 thenPush: pt.
		 ^self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 11.
	argumentCount := 1.
	self normalSend