simulation stack
ssPushAnnotatedConstant: literal
	self ssPush: 1.
	self updateSimSpillBase.
	self ssTop
		type: SSConstant;
		annotateUse: true;
		spilled: false;
		constant: literal;
		bcptr: bytecodePC.
	^0