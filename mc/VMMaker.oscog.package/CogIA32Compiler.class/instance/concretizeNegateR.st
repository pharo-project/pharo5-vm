generate machine code
concretizeNegateR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg |
	reg := operands at: 0.
	machineCode
		at: 0 put: 16rF7;
		at: 1 put: (self mod: ModReg RM: reg RO: 3).
	^machineCodeSize := 2