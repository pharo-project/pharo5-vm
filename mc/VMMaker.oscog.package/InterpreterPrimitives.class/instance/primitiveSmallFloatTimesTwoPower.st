arithmetic float primitives
primitiveSmallFloatTimesTwoPower
	<option: #Spur64BitMemoryManager>
	| rcvr result arg twiceMaxExponent |
	<var: #rcvr type: #double>
	<var: #result type: #double>
	arg := self stackTop.
	(objectMemory isIntegerObject: arg) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := objectMemory smallFloatValueOf: (self stackValue: 1).
	"N.B. SmallFloats are finite.  NaN and Infinity overflow into boxed floats."
	rcvr = 0.0
		ifTrue:
			[result := rcvr]
		ifFalse:
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