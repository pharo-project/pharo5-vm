bytecode generators
genExtStoreAndPopReceiverVariableBytecode
	"235		11101011	i i i i i i i i	Pop and Store Receiver Variable #iiiiiii (+ Extend A * 256)"
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	^(coInterpreter isWriteMediatedContextInstVarIndex: index)
		ifTrue: [self genStorePop: true MaybeContextReceiverVariable: index]
		ifFalse: [self genStorePop: true ReceiverVariable: index]