arithmetic float primitives
primitiveSmallFloatTimesTwoPower
	<option: #Spur64BitMemoryManager>
	| rcvr arg |
	<var: #rcvr type: #double>
	arg := self stackTop.
	(objectMemory isIntegerObject: arg)
		ifTrue:
			[rcvr := objectMemory smallFloatValueOf: (self stackValue: 1).
			 arg := objectMemory integerValueOf: arg.
			 self pop: 1
				thenPushFloat: (self cCode: [self ld: rcvr exp: arg]
									inSmalltalk: [rcvr timesTwoPower: arg])]
		ifFalse:
			[self primitiveFail]