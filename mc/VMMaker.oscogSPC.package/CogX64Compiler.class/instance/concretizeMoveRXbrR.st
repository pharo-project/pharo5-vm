generate machine code
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| src index base offset |
	src := operands at: 0.
	index := operands at: 1.
	base := operands at: 2.
	offset := 0.
	(src > 3 or: [base > 7 or: [index > 7]]) ifTrue:
		[machineCode at: 0 put: (self rexR: src x: index b: base).
		 offset := 1].
	machineCode at: 0 + offset put: 16r88.
	(base bitAnd: 7) ~= RBP "RBP,R13" ifTrue:
		[machineCode
			at: 1 + offset put: (self mod: ModRegInd RM: 4 RO: src);
			at: 2 + offset put: (self s: SIB1 i: index b: base).
		 ^machineCodeSize := 3 + offset].
	machineCode
		at: 1 + offset put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: 2 + offset put: (self s: SIB1 i: index b: base);
		at: 3 + offset put: 0.
	 ^machineCodeSize := 4 + offset