generate machine code - concretize
concretizeMoveM16rR
	<var: #offset type: #sqInt>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	self machineCodeAt: 0 put: (self lhuR: destReg base: srcReg offset: offset).
	^machineCodeSize := 4