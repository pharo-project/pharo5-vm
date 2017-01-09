send bytecodes
extSendBytecode
	"238		11101110	i i i i i j j j	Send Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| byte rcvr |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	numExtB := 0.
	rcvr := self internalStackValue: argumentCount.
	lkupClassTag := objectMemory fetchClassTagOf: rcvr.
	self commonSendOrdinary