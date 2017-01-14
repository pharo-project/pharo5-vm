bytecode generators
genExtPushReceiverVariableBytecode
	"226		11100010	i i i i i i i i	Push Receiver Variable #iiiiiiii (+ Extend A * 256)"
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	^(coInterpreter isReadMediatedContextInstVarIndex: index)
		ifTrue: [self genPushMaybeContextReceiverVariable: index]
		ifFalse: [self genPushReceiverVariable: index]