stack bytecodes
storeAndPopReceiverVariableBytecode
	"Note: This code uses 
	storePointerUnchecked:ofObject:withValue: and does the 
	store check explicitely in order to help the translator 
	produce better code."
	| rcvr top |
	rcvr := self receiver.
	top := self internalStackTop.
	objectMemory storePointer: (currentBytecode bitAnd: 7) ofObject: rcvr withValue: top.
	self fetchNextBytecode.
	self internalPop: 1