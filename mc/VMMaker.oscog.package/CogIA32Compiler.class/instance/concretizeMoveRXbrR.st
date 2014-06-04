generate machine code
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| src index base |
	src := self concreteRegister: (operands at: 0).
	index := self concreteRegister: (operands at: 1).
	base := self concreteRegister: (operands at: 2).
	base ~= EBP ifTrue:
		[machineCode
			at: 0 put: 16r88;
			at: 1 put: (self mod: ModRegInd RM: 4 RO: src);
			at: 2 put: (self s: SIB1 i: index b: base).
		 ^machineCodeSize := 3].
	machineCode
		at: 0 put: 16r88;
		at: 1 put: (self mod: ModRegRegDisp8 RM: 4 RO: src);
		at: 2 put: (self s: SIB1 i: index b: base);
		at: 3 put: 0.
	 ^machineCodeSize := 4