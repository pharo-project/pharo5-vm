generate machine code
concretizeZeroExtend16RR
	"Will get inlined into concretizeAt: switch."
	"movzxwq"
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: (self rexw: true r: destReg x: 0 b: srcReg);
		at: 1 put: 16r0F;
		at: 2 put: 16rB7;
		at: 3 put: (self mod: ModReg RM: srcReg RO: destReg).
	^ machineCodeSize := 4