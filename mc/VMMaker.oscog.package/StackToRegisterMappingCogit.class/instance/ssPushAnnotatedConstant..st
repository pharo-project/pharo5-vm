simulation stack
ssPushAnnotatedConstant: literal
	self ssPush: 1.
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].
	self ssTop
		type: SSConstant;
		annotateUse: true;
		spilled: false;
		constant: literal;
		bcptr: bytecodePC.
	^0