generate machine code - concretize
concretizeSubCqR
	| destReg leftReg rightImm |
	rightImm := operands at: 0.
	destReg := leftReg := operands at: 1.
	
	(rightImm negated between: -16r8000 and: 16r7FFF) ifFalse: [^self concretizeSubCwR].
	
	self machineCodeAt: 0 put: (self addiuR: destReg R: leftReg C: rightImm negated).
	^machineCodeSize := 4