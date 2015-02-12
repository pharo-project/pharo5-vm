arithmetic float primitives
primitiveTimesTwoPower
	<option: #Spur64BitMemoryManager>
	| rcvr result arg twiceMaxExponent |
	<var: #rcvr type: #double>
	<var: #result type: #double>
	arg := self stackTop.
	(objectMemory isIntegerObject: arg) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := objectMemory floatValueOf: (self stackValue: 1).
	((self isFinite: rcvr) and: [rcvr ~= 0])
		ifFalse:
			[result := rcvr]
		ifTrue:
			[arg := objectMemory integerValueOf: arg.
			 twiceMaxExponent := 2 * (1 << self floatExponentBits).
			 arg < twiceMaxExponent negated
				ifTrue:
					[result := rcvr < 0.0 ifTrue: [-0.0] ifFalse: [0.0]]
				ifFalse:
					[arg > twiceMaxExponent
						ifTrue:
							[result := rcvr < 0.0 ifTrue: [-1.0e200 / 1.0e-200] ifFalse: [1.0e200 / 1.0e-200]]
						ifFalse:
							[result := self cCode: [self ld: rcvr exp: arg]
											inSmalltalk: [rcvr timesTwoPower: arg]]]].
	self pop: 2 thenPushFloat: result