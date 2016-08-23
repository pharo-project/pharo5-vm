jump bytecodes
extJumpIfTrue
	"243		11110011	i i i i i i i i	Pop and Jump 0n True i i i i i i i i (+ Extend B * 256, where Extend B >= 0)"
	| byte offset |
	byte := self fetchByte.
	offset := byte + (extB << 8).
	extB := extA := 0.
	self jumplfTrueBy: offset