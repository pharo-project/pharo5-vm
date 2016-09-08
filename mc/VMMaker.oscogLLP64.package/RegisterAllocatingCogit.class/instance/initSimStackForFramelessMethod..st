simulation stack
initSimStackForFramelessMethod: startpc
	super initSimStackForFramelessMethod: startpc.
	simSelf liveRegister: NoReg.
	0 to: simStackPtr do:
		[:i| | desc |
		desc := self simStackAt: 1.
		desc liveRegister: (desc type = SSRegister ifTrue: [desc register] ifFalse: [NoReg])]