generate machine code - concretize
concretizeMoveMwrR
	<var: #offset type: #sqInt>
	| baseReg offset destReg |
	offset := operands at: 0.
	baseReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self machineCodeAt: 0 put: (self lwR: destReg base: baseReg offset: offset).
	^machineCodeSize := 4