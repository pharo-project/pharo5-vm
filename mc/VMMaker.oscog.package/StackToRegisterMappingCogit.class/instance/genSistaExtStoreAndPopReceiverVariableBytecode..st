bytecode generators
genSistaExtStoreAndPopReceiverVariableBytecode: boolean
	| index needsStoreCheck |
	needsStoreCheck := self sistaNeedsStoreCheck.
	extB := 0.
	index := byte1 + (extA << 8).
	extA := 0.
	^(coInterpreter isWriteMediatedContextInstVarIndex: index)
		ifTrue: [self genStorePop: boolean MaybeContextReceiverVariable: index needsStoreCheck: needsStoreCheck]
		ifFalse: [self genStorePop: boolean ReceiverVariable: index needsStoreCheck: needsStoreCheck]