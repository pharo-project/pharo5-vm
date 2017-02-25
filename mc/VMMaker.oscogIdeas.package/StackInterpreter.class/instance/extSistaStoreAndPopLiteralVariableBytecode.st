stack bytecodes
extSistaStoreAndPopLiteralVariableBytecode
	"236		11101100	i i i i i i i i	Pop and Store Literal Variable #iiiiiiii (+ Extend A * 256)
	(3) ExtB lowest bit implies no store check is needed, ExtB next bit implies the object may be a context, other bits in the extension are unused."
	| variableIndex value |
	variableIndex := self fetchByte + (extA << 8).
	value := self internalStackTop.
	self internalPop: 1.
	extA := numExtB := extB := 0.
	self storeLiteralVariable: variableIndex withValue: value.
	self fetchNextBytecode.