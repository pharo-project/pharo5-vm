bytecode generators
genSistaExtStoreAndPopReceiverVariableBytecodePopBoolean: boolean
	| index |
	extB := 0. "Simple cogit don't use the extra flags"
	numExtB := 0.
	index := byte1 + (extA << 8).
	extA := 0.
	^(coInterpreter isWriteMediatedContextInstVarIndex: index)
		ifTrue: [self genStorePop: boolean MaybeContextReceiverVariable: index ]
		ifFalse: [self genStorePop: boolean ReceiverVariable: index ]