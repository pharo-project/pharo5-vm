generate machine code - concretize
concretizePopR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| destReg |
	destReg := self concreteRegister: (operands at: 0).
	"cond | 010 | 0100 | 1 | -Rn- | -Rd- | 0000 0000 0100 " "LDR destReg, [SP], #4"
	self machineCodeAt: 0 put: (self t: 2 o: 4 s: 1 rn: SP rd: destReg shifterOperand: 4).
	^machineCodeSize := 4