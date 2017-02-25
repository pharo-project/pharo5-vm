generate machine code
concretizeMoveRsRs
	"Will get inlined into concretizeAt: switch."
	"MOVSS"
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16rF3;
		at: 1 put: 16r0F;
		at: 2 put: 16r11;
		at: 3 put: (self mod: ModReg RM: destReg RO: srcReg).
	^machineCodeSize := 4