simulation stack
initSimStackForFramelessMethod: startpc
	super initSimStackForFramelessMethod: startpc.
	simSelf liveRegister: ReceiverResultReg.
	0 to: simStackPtr do:
		[:i| | desc |
		desc := self simStackAt: i.
		desc liveRegister: (desc type = SSRegister ifTrue: [desc register] ifFalse: [NoReg])]