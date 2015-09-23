generate machine code
concretizeMoveRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: srcReg x: 0 b: destReg);
		at: 1 put: 16r89;
		at: 2 put: (self mod: ModReg RM: destReg RO: srcReg).
	^machineCodeSize := 3