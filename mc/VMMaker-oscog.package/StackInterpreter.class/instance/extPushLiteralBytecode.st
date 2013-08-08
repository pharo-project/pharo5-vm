stack bytecodes
extPushLiteralBytecode
	"228		11100100	i i i i i i i i	Push Literal #iiiiiiii (+ Extend A * 256)"
	| index |
	index := self fetchByte + (extA << 8).
	self fetchNextBytecode.
	extA := 0.
	self pushLiteralConstant: index