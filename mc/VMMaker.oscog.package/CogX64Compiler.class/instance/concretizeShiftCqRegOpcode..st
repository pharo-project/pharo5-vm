generate machine code
concretizeShiftCqRegOpcode: regOpcode
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| distance reg |
	distance := (operands at: 0) min: 31.
	reg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg).
	distance = 1 ifTrue:
		[machineCode
			at: 1 put: 16rD1;
			at: 2 put: (self mod: ModReg RM: reg RO: regOpcode).
		 ^machineCodeSize := 3].
	machineCode
		at: 1 put: 16rC1;
		at: 2 put: (self mod: ModReg RM: reg RO: regOpcode);
		at: 3 put: distance.
	^machineCodeSize := 4