stack bytecodes
extPushReceiverVariableBytecode
	"226		11100010	i i i i i i i i	Push Receiver Variable #iiiiiiii (+ Extend A * 256)"
	| index |
	index := self fetchByte + (extA << 8).
	self fetchNextBytecode.
	extA := 0.
	self pushMaybeContextReceiverVariable: index