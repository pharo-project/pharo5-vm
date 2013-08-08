simulation stack
ssPushBase: reg offset: offset
	self ssPush: 1.
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].
	self ssTop
		type: SSBaseOffset;
		spilled: false;
		annotateUse: false;
		register: reg;
		offset: offset;
		bcptr: bytecodePC.
	^0