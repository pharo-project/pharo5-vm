generate machine code
concretizeJumpR
	<inline: true>
	| reg |
	reg := operands at: 0.
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg);
		at: 1 put: 16rFF;
		at: 2 put: (self mod: ModReg RM: reg RO: 4).
	^machineCodeSize := 3