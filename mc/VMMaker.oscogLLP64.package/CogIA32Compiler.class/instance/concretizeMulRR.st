generate machine code
concretizeMulRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg1 reg2 |
	reg1 := operands at: 0.
	reg2 := operands at: 1.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16rAF;
		at: 2 put: (self mod: ModReg RM: reg1 RO: reg2).
	^machineCodeSize := 3