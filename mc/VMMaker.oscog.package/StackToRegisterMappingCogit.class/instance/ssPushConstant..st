simulation stack
ssPushConstant: literal
	self ssPush: 1.
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].
	self ssTop
		type: SSConstant;
		spilled: false;
		annotateUse: false;
		constant: literal;
		bcptr: bytecodePC.
	^0