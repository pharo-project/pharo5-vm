generate machine code - concretize
concretizeTstCqR
	| leftReg rightImm |
	rightImm := operands at: 0.
	leftReg := operands at: 1.
	
	(rightImm between: -16r8000 and: 16r7FFF) ifFalse: [^self concretizeTstCwR].
	
	self machineCodeAt: 0 put: (self andiR: Cmp R: leftReg C: rightImm).
	^machineCodeSize := 4