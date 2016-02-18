stack bytecodes
storeAndPopReceiverVariableBytecode
	| rcvr top instVarIndex |
	rcvr := self receiver.
	top := self internalStackTop.
	instVarIndex := currentBytecode bitAnd: 7.
	self internalPop: 1.
	objectMemory
		storePointerImmutabilityCheck: instVarIndex
		ofObject: rcvr
		withValue: top.
	self fetchNextBytecode.