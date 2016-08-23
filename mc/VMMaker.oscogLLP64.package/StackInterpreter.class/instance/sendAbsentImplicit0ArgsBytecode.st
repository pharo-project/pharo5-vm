send bytecodes
sendAbsentImplicit0ArgsBytecode
	"160-175	1010 i i i i		Send To Absent Implicit Receiver Literal Selector #iiii With 0 Arguments"
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 0.
	self commonSendImplicitReceiver