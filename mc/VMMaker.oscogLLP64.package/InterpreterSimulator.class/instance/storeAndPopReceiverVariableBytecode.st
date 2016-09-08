bytecode routines
storeAndPopReceiverVariableBytecode
	"Note: This code uses storePointerUnchecked:ofObject:withValue: and does the store check explicitely in order to help the translator produce better code."

	"Interpreter version has fetchNextBytecode out of order"
	| rcvr top |
	rcvr := receiver.
	top := self internalStackTop.
	(rcvr < youngStart) ifTrue: [
		self possibleRootStoreInto: rcvr value: top.
	].
	self storePointerUnchecked: (currentBytecode bitAnd: 7)
		ofObject: rcvr
		withValue: top.
	self internalPop: 1.
	self fetchNextBytecode.
