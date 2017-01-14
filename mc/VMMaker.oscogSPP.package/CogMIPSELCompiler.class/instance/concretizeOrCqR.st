generate machine code - concretize
concretizeOrCqR
	| destReg leftReg rightImm |
	rightImm := operands at: 0.
	destReg := leftReg := operands at: 1.

	(rightImm between: 0 and: 16rFFFF) ifFalse: [^self concretizeOrCwR].
	
	self machineCodeAt: 0 put: (self oriR: destReg R: leftReg C: rightImm).
	^machineCodeSize := 4