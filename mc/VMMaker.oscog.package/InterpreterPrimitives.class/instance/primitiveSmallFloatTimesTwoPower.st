arithmetic float primitives
primitiveSmallFloatTimesTwoPower
	"Multiply the receiver by the power of the argument."
	<option: #Spur64BitMemoryManager>
	| rcvr result arg twiceMaxExponent |
	arg := self stackTop.
	(objectMemory isIntegerObject: arg) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	"N.B. SmallFloats are finite.  NaN and Infinity overflow into boxed floats.
	 This is doing range checking work that is done in ldexp, but we include
	 it explicitly to exemplify bit manipulation of SmallFloats."
	(objectMemory isSmallFloatZero: rcvr)
		ifTrue:
			[result := rcvr]
		ifFalse:
			[arg := objectMemory integerValueOf: arg.
			 twiceMaxExponent := 2 * (1 << self floatExponentBits).
			 arg < twiceMaxExponent negated
				ifTrue:
					[result := objectMemory mapSignedSmallFloatToSignedSmallFloatZero: rcvr]
				ifFalse:
					["clip arg to at most int range; ldexp's last arg is of type int"
					 arg > twiceMaxExponent ifTrue: [arg := twiceMaxExponent].
					 result := objectMemory floatObjectOf: (self cCode: [self ld: (objectMemory smallFloatValueOf: rcvr)
																				exp: (self cCoerceSimple: arg to: #int)]
																inSmalltalk: [(objectMemory smallFloatValueOf: rcvr) timesTwoPower: arg])]].
	self pop: 2 thenPush: result