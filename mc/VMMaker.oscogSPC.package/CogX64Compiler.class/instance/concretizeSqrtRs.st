generate machine code
concretizeSqrtRs
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg skip |
	reg := operands at: 0.
	machineCode
		at: 0 put: 16rF3.
	(reg <= 7)
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: reg x: 0 b: reg)].
	machineCode
		at: skip + 1 put: 16r0F;
		at: skip + 2 put: 16r51;
		at: skip + 3 put: (self mod: ModReg RM: reg RO: reg).
	^machineCodeSize := skip + 4