bytecode generators
genExtStoreLiteralVariableBytecode
	"233		11101001	i i i i i i i i	Store Literal Variable #iiiiiiii (+ Extend A * 256)"
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	^self genStorePop: false LiteralVariable: index