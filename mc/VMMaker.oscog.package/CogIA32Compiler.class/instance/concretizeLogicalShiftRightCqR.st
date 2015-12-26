generate machine code
concretizeLogicalShiftRightCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| distance reg |
	distance := (operands at: 0) min: 31.
	reg := operands at: 1.
	distance = 1 ifTrue:
		[machineCode
			at: 0 put: 16rD1;
			at: 1 put: (self mod: ModReg RM: reg RO: 5).
		 ^machineCodeSize := 2].
	machineCode
		at: 0 put: 16rC1;
		at: 1 put: (self mod: ModReg RM: reg RO: 5);
		at: 2 put: distance.
	^machineCodeSize := 3