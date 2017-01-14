simulation stack
initSimStackForFramefulMethod: startpc
	super initSimStackForFramefulMethod: startpc.
	simSelf liveRegister: NoReg.
	0 to: simStackPtr do:
		[:i| (self simStackAt: i) liveRegister: NoReg]