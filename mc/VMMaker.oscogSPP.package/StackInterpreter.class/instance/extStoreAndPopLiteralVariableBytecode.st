stack bytecodes
extStoreAndPopLiteralVariableBytecode
	"236		11101100	i i i i i i i i	Pop and Store Literal Variable #iiiiiiii (+ Extend A * 256)"
	| variableIndex value |
	variableIndex := self fetchByte + (extA << 8).
	value := self internalStackTop.
	self internalPop: 1.
	extA := 0.
	self storeLiteralVariable: variableIndex withValue: value.
	self fetchNextBytecode.