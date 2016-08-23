bytecode generators
genSendAbsentImplicit0ArgsBytecode
	"160-175	1010 i i i i		Send To Absent Implicit Receiver Literal Selector #iiii With 0 Arguments."
	^self genSendAbsentImplicit: (byte0 bitAnd: 15) numArgs: 0