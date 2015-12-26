generate machine code
concretizeMoveRXwrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base src |
	src := operands at: 0.
	index := operands at: 1.
	base := operands at: 2.
	machineCode
		at: 0 put: (self rexR: src x: index b: base).
	(base ~= RBP and: [base ~= R13]) ifTrue:
		[machineCode
			at: 1 put: 16r89;
			at: 2 put: (self mod: ModRegInd RM: 4 RO: src);
			at: 3 put: (self s: SIB8 i: index b: base).
		 ^machineCodeSize := 4].
	machineCode
		at: 1 put: 16r89;
		at: 2 put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: 3 put: (self s: SIB8 i: index b: base);
		at: 4 put: 0.
	 ^machineCodeSize := 5