stack bytecodes
storeAndPopReceiverVariableBytecode
	"Note: This code uses 
	storePointerUnchecked:ofObject:withValue: and does the 
	store check explicitely in order to help the translator 
	produce better code."
	| rcvr top |
	rcvr := self receiver.
	top := self internalStackTop.
	self internalPop: 1.
	self fetchNextBytecode.
	objectMemory storePointerImmutabilityCheck: (currentBytecode bitAnd: 7) ofObject: rcvr withValue: top.