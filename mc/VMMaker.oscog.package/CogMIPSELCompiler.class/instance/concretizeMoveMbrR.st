generate machine code - concretize
concretizeMoveMbrR
	<var: #offset type: #sqInt>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	self machineCodeAt: 0 put: (self lbuR: destReg base: srcReg offset: offset).
	^machineCodeSize := 4
	