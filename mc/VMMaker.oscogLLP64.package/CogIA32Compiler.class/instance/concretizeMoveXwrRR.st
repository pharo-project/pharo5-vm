generate machine code
concretizeMoveXwrRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base dest |
	index := operands at: 0.
	base := operands at: 1.
	dest := operands at: 2.
	base ~= EBP ifTrue:
		[machineCode
			at: 0 put: 16r8B;
			at: 1 put: (self mod: ModRegInd RM: 4 RO: dest);
			at: 2 put: (self s: SIB4 i: index b: base).
		 ^machineCodeSize := 3].
	machineCode
		at: 0 put: 16r8B;
		at: 1 put: (self mod: ModRegRegDisp8 RM: 4 RO: dest);
		at: 2 put: (self s: SIB4 i: index b: base);
		at: 3 put: 0.
	 ^machineCodeSize := 4