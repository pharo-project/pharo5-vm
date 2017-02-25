simulation stack
ssPushRegister: reg
	self ssPush: 1.
	self updateSimSpillBase.
	self ssTop
		type: SSRegister;
		spilled: false;
		register: reg;
		bcptr: bytecodePC.
	^0