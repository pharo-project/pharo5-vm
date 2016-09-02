inline primitive generators
genNullaryInlinePrimitive: prim
	"Nullary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#nullaryInlinePrimitive:"

	<option: #SistaVM>
	^EncounteredUnknownBytecode