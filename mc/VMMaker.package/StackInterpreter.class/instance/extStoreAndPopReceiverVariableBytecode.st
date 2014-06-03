stack bytecodes
extStoreAndPopReceiverVariableBytecode
	"235		11101011	i i i i i i i i	Pop and Store Receiver Variable #iiiiiii (+ Extend A * 256)"
	self extStoreReceiverVariableBytecode.
	self internalPop: 1