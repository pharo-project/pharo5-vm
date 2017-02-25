stack bytecodes
extStoreAndPopReceiverVariableBytecode
	"235		11101011	i i i i i i i i	Pop and Store Receiver Variable #iiiiiii (+ Extend A * 256)"
	| variableIndex value |
	variableIndex := self fetchByte + (extA << 8).
	extA := 0.
	value := self internalStackTop.
	self internalPop: 1.
	self storeMaybeContextReceiverVariable: variableIndex withValue: value.
	self fetchNextBytecode.