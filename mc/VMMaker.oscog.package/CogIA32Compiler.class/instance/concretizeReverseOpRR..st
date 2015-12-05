generate machine code
concretizeReverseOpRR: opcode
	| regLHS regRHS |
	regRHS := self concreteRegister: (operands at: 0).
	regLHS := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: opcode;
		at: 1 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 2