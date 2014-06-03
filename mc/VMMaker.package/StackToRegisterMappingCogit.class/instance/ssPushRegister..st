simulation stack
ssPushRegister: reg
	self ssPush: 1.
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].
	self ssTop
		type: SSRegister;
		spilled: false;
		annotateUse: false;
		register: reg;
		bcptr: bytecodePC.
	^0