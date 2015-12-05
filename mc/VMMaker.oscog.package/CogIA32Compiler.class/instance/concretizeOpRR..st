generate machine code
concretizeOpRR: opcode
	| regLHS regRHS |
	regLHS := self concreteRegister: (operands at: 0).
	regRHS := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: opcode;
		at: 1 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 2