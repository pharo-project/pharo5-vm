testing
isValidFramelessRegister: reg
	"Answer if the receiver is valid in a frameless method."
	^reg = ReceiverResultReg or: [reg = Arg0Reg]