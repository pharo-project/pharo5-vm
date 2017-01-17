generate machine code
concretizeConvertRsR
	"Will get inlined into concretizeAt: switch."
	"CVTSS2SI"
	<inline: true>
	| srcReg destReg skip |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16rF3.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: destReg x: 0 b: srcReg)].
		
	machineCode 
		at: skip + 1 put: 16r0F;
		at: skip + 2 put: 16r2D;
		at: skip + 3 put: (self mod: ModReg RM: srcReg RO: destReg).
	 ^machineCodeSize := skip + 4