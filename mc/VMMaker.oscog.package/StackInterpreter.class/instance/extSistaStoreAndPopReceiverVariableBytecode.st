stack bytecodes
extSistaStoreAndPopReceiverVariableBytecode
	"235		11101011	i i i i i i i i	Pop and Store Receiver Variable #iiiiiii (+ Extend A * 256)
	(3) ExtB lowest bit implies no store check is needed, ExtB next bit implies the object may be a context, other bits in the extension are unused."
	| variableIndex value |
	variableIndex := self fetchByte + (extA << 8).
	extA := numExtB := extB := 0.
	value := self internalStackTop.
	self internalPop: 1.
	self storeMaybeContextReceiverVariable: variableIndex withValue: value.
	self fetchNextBytecode.