generate machine code
concretizeConvertRRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := self concreteRegister: (operands at:0).
	destReg := self concreteDPFPRegister: (operands at: 1).
	machineCode
		at: 0 put: 16rF2;
		at: 1 put: 16r0F;
		at: 2 put: 16r2A;
		at: 3 put: (self mod: ModReg RM: srcReg RO: destReg).
	 ^machineCodeSize := 4