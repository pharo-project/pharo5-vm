inline primitive generators
genTrinaryInlinePrimitive: prim
	"trinary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#trinaryInlinePrimitive:"

	prim < 10 ifTrue: [^ self genAtPutInlinePrimitive: prim].
	prim = 21 ifTrue: [^ self genByteEqualsInlinePrimitive: prim].
	^ EncounteredUnknownBytecode