generate machine code - concretize
concretizeMoveRMwr
	<var: #offset type: #sqInt>
	| srcReg offset baseReg |
	srcReg := operands at: 0.
	offset := operands at: 1.
	baseReg := operands at: 2.
	self machineCodeAt: 0 put: (self swR: srcReg base: baseReg offset: offset).
	^machineCodeSize := 4