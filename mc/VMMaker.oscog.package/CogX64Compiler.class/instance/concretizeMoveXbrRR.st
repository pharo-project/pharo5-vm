generate machine code
concretizeMoveXbrRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| index base dest |
	index := self concreteRegister: (operands at: 0).
	base := self concreteRegister: (operands at: 1).
	dest := self concreteRegister: (operands at: 2).
	machineCode
		at: 0 put: (self rexR: dest x: index b: base);
		at: 1 put: 16r0F;
		at: 2 put: 16rB6.
	(base ~= RBP and: [base ~= R13]) ifTrue:
		[machineCode
			at: 3 put: (self mod: ModRegInd RM: 4 RO: dest);
			at: 4 put: (self s: SIB1 i: index b: base).
		 ^machineCodeSize := 5].
	machineCode
		at: 3 put: (self mod: ModRegRegDisp8 RM: 4 RO: dest);
		at: 4 put: (self s: SIB1 i: index b: base);
		at: 5 put: 0.
	 ^machineCodeSize := 6