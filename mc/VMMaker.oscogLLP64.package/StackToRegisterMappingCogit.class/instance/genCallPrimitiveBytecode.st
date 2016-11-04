bytecode generators
genCallPrimitiveBytecode
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#inlinePrimitiveBytecode:"
	| prim primSet |
	byte2 < 128 ifTrue:
		[^bytecodePC = initialPC
			ifTrue: [0]
			ifFalse: [EncounteredUnknownBytecode]].
	prim := byte2 - 128 << 8 + byte1.
	primSet := prim >> 13 bitAnd: 3.
	prim := prim bitAnd: 8191.
	LowcodeVM
		ifTrue:
			[
			primSet = 1 ifTrue: [
				prim < 1000 ifTrue:
					[^self genLowcodeNullaryInlinePrimitive: prim].

				prim < 2000 ifTrue:
					[^self genLowcodeUnaryInlinePrimitive: prim - 1000].
				
				prim < 3000 ifTrue:
					[^ self genLowcodeBinaryInlinePrimitive: prim - 2000].

				prim < 4000 ifTrue:
					[^self genLowcodeTrinaryInlinePrimitive: prim - 3000].
			]
		].

	^EncounteredUnknownBytecode