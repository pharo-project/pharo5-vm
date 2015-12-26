generate machine code - concretize
concretizeAndCqR
	| destReg leftReg rightImm |
	rightImm := operands at: 0.
	destReg := leftReg := operands at: 1.
	
	(rightImm between: -16r8000 and: 16r7FFF) ifFalse: [^self concretizeAndCwR].
	
	self machineCodeAt: 0 put: (self andiR: destReg R: leftReg C: rightImm).
	^machineCodeSize := 4