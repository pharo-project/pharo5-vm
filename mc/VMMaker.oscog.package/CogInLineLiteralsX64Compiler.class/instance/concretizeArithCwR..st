generate machine code
concretizeArithCwR: x64opcode
	| value reg reverse |
	value := operands at: 0.
	reg := operands at: 1.
	reverse := x64opcode = 16r85 or: [x64opcode = 16r39]. "Tst & Cmp; backwards"
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
		at: 10 put: (reverse
					ifTrue: [self rexR: RISCTempReg x: 0 b: reg]
					ifFalse: [self rexR: reg x: 0 b: RISCTempReg]);
		at: 11 put: x64opcode;
		at: 12 put: (reverse
					ifTrue: [self mod: ModReg RM: reg RO: RISCTempReg]
					ifFalse: [self mod: ModReg RM: RISCTempReg RO: reg]).
	^machineCodeSize := 13