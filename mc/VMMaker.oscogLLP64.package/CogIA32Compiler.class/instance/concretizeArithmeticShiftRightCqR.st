generate machine code
concretizeArithmeticShiftRightCqR
	<inline: true>
	| shiftCount reg |
	shiftCount := (operands at: 0) min: 31.
	reg := operands at: 1.
	shiftCount = 1 ifTrue:
		[machineCode
			at: 0 put: 16rD1;
			at: 1 put: (self mod: ModReg RM: reg RO: 7).
		^machineCodeSize := 2].

	machineCode
		at: 0 put: 16rC1;
		at: 1 put: (self mod: ModReg RM: reg RO: 7);
		at: 2 put: shiftCount.
	^machineCodeSize := 3