generate machine code
concretizeShiftCqRegOpcode: regOpcode
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| distance reg |
	distance := operands at: 0.
	self assert: (distance between: 1 and: 63).
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
		at: 3 put: (distance min: 31).
	distance <= 31 ifTrue:
		[^machineCodeSize := 4].
	distance = 32 ifTrue:
		[machineCode
			at: 4 put: 16rD1;
			at: 5 put: (self mod: ModReg RM: reg RO: regOpcode).
		 ^machineCodeSize := 7].
	machineCode
		at: 4 put: 16rC1;
		at: 5 put: (self mod: ModReg RM: reg RO: regOpcode);
		at: 6 put: distance - 31.
	^machineCodeSize := 8