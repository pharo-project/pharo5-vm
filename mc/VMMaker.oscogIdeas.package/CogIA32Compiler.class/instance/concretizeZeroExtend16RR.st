generate machine code
concretizeZeroExtend16RR
	"Will get inlined into concretizeAt: switch."
	"movzwl"
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16rB7;
		at: 2 put: (self mod: ModReg RM: srcReg RO: destReg).
	^ machineCodeSize := 3