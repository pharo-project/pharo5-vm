jump bytecodes
extJumpIfFalse
	"244		11110100	i i i i i i i i	Pop and Jump 0n False i i i i i i i i (+ Extend B * 256, where Extend B >= 0)"
	| byte offset |
	byte := self fetchByte.
	offset := byte + (extB << 8).
	numExtB := extB := extA := 0.
	self jumplfFalseBy: offset