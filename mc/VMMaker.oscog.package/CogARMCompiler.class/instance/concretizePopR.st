generate machine code - concretize
concretizePopR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| destReg |
	destReg := operands at: 0.
	"LDR destReg, [SP], #4"
	self machineCodeAt: 0 put: (self popR: destReg).
	^machineCodeSize := 4