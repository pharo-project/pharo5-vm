generate machine code
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| src index base swapreg mcIdx |
	src := operands at: 0.
	index := operands at: 1.
	base := operands at: 2.
	mcIdx := 0.
	swapreg := NoReg.
	src >= 4 ifTrue: "x86 allows movb %rl, mem only with %al, %bl, %cl, %dl, so swap with the first one that isn't used."
		[swapreg := src.
		 index = EAX ifTrue: [index := swapreg].
		 base = EAX ifTrue: [base := swapreg].
		 src := EAX. 
		 mcIdx := 1.
		 machineCode at: 0 put: 16r90 + swapreg].
	base ~= EBP ifTrue:
		[machineCode
			at: mcIdx + 0 put: 16r88;
			at: mcIdx + 1 put: (self mod: ModRegInd RM: 4 RO: src);
			at: mcIdx + 2 put: (self s: SIB1 i: index b: base).
		 swapreg ~= NoReg ifTrue:
			[machineCode at: mcIdx + 3 put: 16r90 + swapreg].
		 ^machineCodeSize := 3 + (2 * mcIdx)].
	machineCode
		at: mcIdx + 0 put: 16r88;
		at: mcIdx + 1 put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: mcIdx + 2 put: (self s: SIB1 i: index b: base);
		at: mcIdx + 3 put: 0.
	swapreg ~= NoReg ifTrue:
		[machineCode at: mcIdx + 4 put: 16r90 + swapreg].
	 ^machineCodeSize := 4 + (2 * mcIdx)