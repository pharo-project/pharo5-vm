generate machine code - concretize
concretizePushR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg |
	srcReg := self concreteRegister: (operands at: 0).
	"cond | 010 | 1001 | 0 | -Rn- | -Rd- | 0000 0000 0100" "STR srcReg, [sp, #-4]"
	self machineCodeAt: 0 put: (self t: 2 o: 9 s: 0 rn: SP rd: srcReg shifterOperand: 4).
	^machineCodeSize := 4