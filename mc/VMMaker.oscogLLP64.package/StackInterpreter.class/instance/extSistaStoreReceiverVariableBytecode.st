stack bytecodes
extSistaStoreReceiverVariableBytecode
	"232		11101000	i i i i i i i i	Store Receiver Variable #iiiiiii (+ Extend A * 256)
	(3) ExtB lowest bit implies no store check is needed, ExtB next bit implies the object may be a context, other bits in the extension are unused."
	| variableIndex |
	variableIndex := self fetchByte + (extA << 8).
	extA := extB := 0.
	self storeMaybeContextReceiverVariable: variableIndex withValue: self internalStackTop.
	self fetchNextBytecode.