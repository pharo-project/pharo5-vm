generate machine code
concretizeReverseOpRR: x86opcode
	| regLHS regRHS |
	regRHS := self concreteRegister: (operands at: 0).
	regLHS := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: x86opcode;
		at: 1 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 2