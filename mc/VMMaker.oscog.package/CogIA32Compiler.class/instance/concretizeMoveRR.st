generate machine code
concretizeMoveRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: 16r89;
		at: 1 put: (self mod: ModReg RM: destReg RO: srcReg).
	^machineCodeSize := 2