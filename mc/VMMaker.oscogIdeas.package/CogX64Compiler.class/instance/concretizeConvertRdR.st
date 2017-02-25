generate machine code
concretizeConvertRdR
	"Will get inlined into concretizeAt: switch."
	"CVTSD2SI"
	<inline: true>
	| srcReg destReg |
	srcReg := operands at:0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16rF2;
		at: 1 put: (self rexR: destReg x: 0 b: srcReg);
		at: 2 put: 16r0F;
		at: 3 put: 16r2D;
		at: 4 put: (self mod: ModReg RM: srcReg RO: destReg).
	 ^machineCodeSize := 5