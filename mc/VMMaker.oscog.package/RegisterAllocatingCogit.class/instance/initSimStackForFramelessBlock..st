simulation stack
initSimStackForFramelessBlock: startpc
	super initSimStackForFramelessBlock: startpc.
	simSelf liveRegister: ReceiverResultReg.
	0 to: simStackPtr do:
		[:i| (self simStackAt: i) liveRegister: NoReg]