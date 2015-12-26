generate machine code
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base dest offset |
	index := operands at: 0.
	base := operands at: 1.
	dest := operands at: 2.
	offset := 0.
	(dest >= 8 or: [base >= 8 or: [index >= 8]]) ifTrue:
		[machineCode at: 0 put: (self rexR: dest x: index b: base).
		 offset := 1].
	machineCode
		at: 0 + offset put: 16r88.
	(base ~= RBP and: [base ~= R13]) ifTrue:
		[machineCode
			at: 1 + offset put: (self mod: ModRegInd RM: 4 RO: dest);
			at: 2 + offset put: (self s: SIB1 i: index b: base).
		 ^machineCodeSize := 3 + offset].
	machineCode
		at: 1 + offset put: (self mod: ModRegRegDisp8 RM: 4 RO: dest);
		at: 2 + offset put: (self s: SIB1 i: index b: base);
		at: 3 + offset put: 0.
	 ^machineCodeSize := 4 + offset