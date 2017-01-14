generate machine code
concretizeCallR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg |
	"CmpRR RHS LHS computes LHS - RHS, i.e. apparently reversed.  You have to think subtract."
	reg := operands at: 0.
	machineCode
		at: 0 put: 16rFF;
		at: 1 put: (self mod: ModReg RM: reg RO: 2).
	^machineCodeSize := 2