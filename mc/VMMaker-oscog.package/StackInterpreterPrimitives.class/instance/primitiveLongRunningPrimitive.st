process primitives
primitiveLongRunningPrimitive
	"Primitive. Answer an Array with the current long-running primitive method identified by
	 the heartbeat, the minimum number of milliseconds it was active for, and the milliseconds
	 of GC activity there-in, or nil if none.  Since the longRunningPrimitiveCheckMethod is
	 sampled at interrupt time be careful to validate it before returning it."
	<export: true>
	| lrpcm result primms gcms |
	self methodArgumentCount = 0 ifFalse:
		[^self primitiveFail].
	self sqLowLevelMFence.
	(longRunningPrimitiveStopUsecs > longRunningPrimitiveStartUsecs "a hit"
	 and: [(lrpcm := longRunningPrimitiveCheckMethod) ~= nil			"there is a method"
	 and: [(self addressCouldBeObj: lrpcm)								"method looks valid"
	 and: [(self isFreeObject: lrpcm) not
	 and: [(self isCompiledMethod: lrpcm)]]]])
		ifTrue: [result := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: 3.
				primms := (longRunningPrimitiveStopUsecs - longRunningPrimitiveStartUsecs) + 500 // 1000.
				
				gcms := longRunningPrimitiveGCUsecs + 500 // 1000.
				objectMemory storePointer: 0 ofObject: result withValue: lrpcm.
				objectMemory storePointerUnchecked: 1 ofObject: result withValue: (objectMemory integerObjectOf: primms).
				objectMemory storePointerUnchecked: 2 ofObject: result withValue: (objectMemory integerObjectOf: gcms)]
		ifFalse: [result := objectMemory nilObject].
	self pop: 1 thenPush: result.
	self voidLongRunningPrimitive: 'get'