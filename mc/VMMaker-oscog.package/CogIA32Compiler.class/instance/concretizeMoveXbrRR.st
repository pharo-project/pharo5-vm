generate machine code
concretizeMoveXbrRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base dest |
	index := self concreteRegister: (operands at: 0).
	base := self concreteRegister: (operands at: 1).
	dest := self concreteRegister: (operands at: 2).
	base ~= EBP ifTrue:
		[machineCode
			at: 0 put: 16r0F;
			at: 1 put: 16rB6;
			at: 2 put: (self mod: ModRegInd RM: 4 RO: dest);
			at: 3 put: (self s: SIB1 i: index b: base).
		 ^machineCodeSize := 4].
	machineCode
			at: 0 put: 16r0F;
			at: 1 put: 16rB6;
		at: 2 put: (self mod: ModRegRegDisp8 RM: 4 RO: dest);
		at: 3 put: (self s: SIB1 i: index b: base);
		at: 4 put: 0.
	 ^machineCodeSize := 5