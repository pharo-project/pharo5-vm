bytecode generators
genExtPushLiteralBytecode
	"228		11100100	i i i i i i i i	Push Literal #iiiiiiii (+ Extend A * 256)"
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	^self genPushLiteralIndex: index