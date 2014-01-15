send bytecodes
sendLiteralSelector0ArgsBytecode
	"Can use any of the first 16 literals for the selector."
	| rcvr |
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 0.
	rcvr := self internalStackValue: 0.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	self commonSend