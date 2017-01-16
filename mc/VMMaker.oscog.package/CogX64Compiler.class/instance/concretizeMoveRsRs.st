generate machine code
concretizeMoveRsRs
	"Will get inlined into concretizeAt: switch."
	"MOVSS"
	<inline: true>
	| srcReg destReg skip |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16rF3.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: srcReg x: 0 b: destReg)].
	machineCode
		at: skip + 1 put: 16r0F;
		at: skip + 2 put: 16r11;
		at: skip + 3 put: (self mod: ModReg RM: destReg RO: srcReg).
	^machineCodeSize := skip + 4