stack bytecodes
extStoreLiteralVariableBytecode
	"233		11101001	i i i i i i i i	Store Literal Variable #iiiiiiii (+ Extend A * 256)"
	| variableIndex |
	variableIndex := self fetchByte + (extA << 8).
	self fetchNextBytecode.
	extA := 0.
	self storeLiteralVariable: variableIndex withValue: self internalStackTop