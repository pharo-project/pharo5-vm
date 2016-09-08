generate machine code
concretizeMoveRX32rR
	| index base src offset |
	src := operands at: 0.
	index := operands at: 1.
	base := operands at: 2.
	(index > 7 or: [base > 7 or: [src > 7]])
		ifTrue:
			[machineCode at: 0 put: (self rexw: false r: src x: index b: base).
			 offset := 1]
		ifFalse:
			[offset := 0].
	(base bitAnd: 7) ~= RBP ifTrue:
		[machineCode
			at: offset + 0 put: 16r89;
			at: offset + 1 put: (self mod: ModRegInd RM: 4 RO: src);
			at: offset + 2 put: (self s: SIB4 i: index b: base).
		 ^machineCodeSize := offset + 3].
	machineCode
		at: offset + 0 put: 16r89;
		at: offset + 1 put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: offset + 2 put: (self s: SIB4 i: index b: base);
		at: offset + 3 put: 0.
	 ^machineCodeSize := offset + 4