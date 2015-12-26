generate machine code
concretizeMulRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg1 reg2 |
	reg1 := operands at: 0.
	reg2 := operands at: 1.
	machineCode
		at: 0 put: (self rexR: reg2 x: 0 b: reg1);
		at: 1 put: 16r0F;
		at: 2 put: 16rAF;
		at: 3 put: (self mod: ModReg RM: reg1 RO: reg2).
	^machineCodeSize := 4