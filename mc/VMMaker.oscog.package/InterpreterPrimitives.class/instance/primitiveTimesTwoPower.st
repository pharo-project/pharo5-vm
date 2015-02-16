arithmetic float primitives
primitiveTimesTwoPower
	"Multiply the receiver by the power of the argument."
	| rcvr result arg |
	<var: #rcvr type: #double>
	<var: #result type: #double>
	arg := self stackTop.
	(objectMemory isIntegerObject: arg) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	arg := objectMemory integerValueOf: arg.
	objectMemory bytesPerOop > 4 ifTrue:
		[| twiceMaxExponent | "clip arg to at most int range; ldexp's last arg is of type int"
		 twiceMaxExponent := 2 * (1 << self floatExponentBits).
	 	 arg < twiceMaxExponent negated
			ifTrue: [arg := twiceMaxExponent negated]
			ifFalse: [arg > twiceMaxExponent ifTrue:
						[arg := twiceMaxExponent]]].
	rcvr := objectMemory floatValueOf: (self stackValue: 1).
	result := self cCode: [self ld: rcvr exp: (self cCoerceSimple: arg to: #int)]
					inSmalltalk: [rcvr timesTwoPower: arg].
	self pop: 2 thenPushFloat: result