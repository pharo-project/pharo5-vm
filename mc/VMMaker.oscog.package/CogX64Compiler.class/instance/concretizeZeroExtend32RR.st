generate machine code
concretizeZeroExtend32RR
	"Will get inlined into concretizeAt: switch."
	"movzxbq"
	<inline: true>
	| srcReg destReg skip |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [skip := 1. machineCode at: 0 put: (self rexw: false r: destReg x: 0 b: srcReg)].
		
	machineCode
		at: skip + 0 put: 16r8b;
		at: skip + 1 put: (self mod: ModReg RM: srcReg RO: destReg).
	^ machineCodeSize := skip + 2