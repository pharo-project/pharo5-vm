stack bytecodes
extStoreLiteralVariableBytecode
	"233		11101001	i i i i i i i i	Store Literal Variable #iiiiiiii (+ Extend A * 256)"
	| association variableIndex |
	variableIndex := self fetchByte + (extA << 8).
	self fetchNextBytecode.
	extA := 0.
	association := self literal: variableIndex.
	objectMemory storePointer: ValueIndex ofObject: association withValue: self internalStackTop