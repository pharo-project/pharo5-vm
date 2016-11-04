generate machine code
concretizeSqrtRs
	"Will get inlined into concretizeAt: switch."
	"SRTSS"
	<inline: true>
	| reg |
	reg := operands at: 0.
	machineCode
		at: 0 put: 16rF3;
		at: 1 put: 16r0F;
		at: 2 put: 16r51;
		at: 3 put: (self mod: ModReg RM: reg RO: reg).
	^machineCodeSize := 4