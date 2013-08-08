stack bytecodes
extPushLiteralVariableBytecode
	"227		11100011	i i i i i i i i	Push Literal Variable #iiiiiiii (+ Extend A * 256)"
	| index |
	index := self fetchByte + (extA << 8).
	self fetchNextBytecode.
	extA := 0.
	self pushLiteralVariable: index