generate machine code
concretizeMoveX32rRR
	"MoveX32rRR is expected to zero-extend, so explicitly zero the destination."
	| index base dest offset |
	index := operands at: 0.
	base := operands at: 1.
	dest := operands at: 2.
	machineCode
		at: 0 put: (self rexR: dest x: 0 b: dest);
		at: 1 put: 16r31;
		at: 2 put: (self mod: ModReg RM: dest RO: dest).
	(index > 7 or: [base > 7 or: [dest > 7]])
		ifTrue:
			[machineCode at: 3 put: (self rexw: false r: dest x: index b: base).
			 offset := 1]
		ifFalse:
			[offset := 0].
	(base bitAnd: 7) ~= RBP ifTrue:
		[machineCode
			at: offset + 3 put: 16r8B;
			at: offset + 4 put: (self mod: ModRegInd RM: 4 RO: dest);
			at: offset + 5 put: (self s: SIB4 i: index b: base).
		 ^machineCodeSize := offset + 6].
	machineCode
		at: offset + 3 put: 16r8B;
		at: offset + 4 put: (self mod: ModRegRegDisp8 RM: 4 RO: dest);
		at: offset + 5 put: (self s: SIB4 i: index b: base);
		at: offset + 6 put: 0.
	 ^machineCodeSize := offset + 7