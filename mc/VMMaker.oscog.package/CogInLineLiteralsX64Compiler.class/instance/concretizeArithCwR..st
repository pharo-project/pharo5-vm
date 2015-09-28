generate machine code
concretizeArithCwR: opcode
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	machineCode
		at:  0 put: (self rexR: RISCTempReg x: 0 b: RISCTempReg);
		at:  1 put: 16rB8 + (RISCTempReg bitAnd: 7);
		at:  2 put: (value bitAnd: 16rFF);
		at:  3 put: (value >> 8 bitAnd: 16rFF);
		at:  4 put: (value >> 16 bitAnd: 16rFF);
		at:  5 put: (value >> 24 bitAnd: 16rFF);
		at:  6 put: (value >> 32 bitAnd: 16rFF);
		at:  7 put: (value >> 40 bitAnd: 16rFF);
		at:  8 put: (value >> 48 bitAnd: 16rFF);
		at:  9 put: (value >> 56 bitAnd: 16rFF);
		at: 10 put: (self rexR: RISCTempReg x: 0 b: reg);
		at: 11 put: opcode;
		at: 12 put: (self mod: ModReg RM: reg RO: RISCTempReg).
	^machineCodeSize := 13