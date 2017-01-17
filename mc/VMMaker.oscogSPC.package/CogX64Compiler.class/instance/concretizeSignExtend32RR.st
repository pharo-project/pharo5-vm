generate machine code
concretizeSignExtend32RR
	"Will get inlined into concretizeAt: switch."
	"movsxdq"
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: (self rexw: true r: destReg x: 0 b: srcReg);
		at: 1 put: 16r63;
		at: 2 put: (self mod: ModReg RM: srcReg RO: destReg).
	^ machineCodeSize := 3