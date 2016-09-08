generate machine code
concretizeMoveRXwrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base src |
	src := operands at: 0.
	index := operands at: 1.
	base := operands at: 2.
	base ~= EBP ifTrue:
		[machineCode
			at: 0 put: 16r89;
			at: 1 put: (self mod: ModRegInd RM: 4 RO: src);
			at: 2 put: (self s: SIB4 i: index b: base).
		 ^machineCodeSize := 3].
	machineCode
		at: 0 put: 16r89;
		at: 1 put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: 2 put: (self s: SIB4 i: index b: base);
		at: 3 put: 0.
	 ^machineCodeSize := 4