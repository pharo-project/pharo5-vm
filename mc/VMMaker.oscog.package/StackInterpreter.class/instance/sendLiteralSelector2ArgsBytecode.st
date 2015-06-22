send bytecodes
sendLiteralSelector2ArgsBytecode
	"Can use any of the first 16 literals for the selector."
	| rcvr |
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 2.
	rcvr := self internalStackValue: 2.
	lkupClassTag := objectMemory fetchClassTagOf: rcvr.
	self assert: lkupClassTag ~= objectMemory nilObject.
	self commonSendOrdinary