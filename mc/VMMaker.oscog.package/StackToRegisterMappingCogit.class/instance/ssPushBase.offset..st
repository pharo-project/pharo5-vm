simulation stack
ssPushBase: reg offset: offset
	self ssPush: 1.
	self updateSimSpillBase.
	self ssTop
		type: SSBaseOffset;
		spilled: false;
		annotateUse: false;
		register: reg;
		offset: offset;
		bcptr: bytecodePC.
	^0