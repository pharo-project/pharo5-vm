generate machine code - concretize
concretizeMoveAwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcAddr destReg instrOffset|
	srcAddr := operands at: 0.
	destReg := self concreteRegister: (operands at: 1).
	"load the address into RISCTempReg"
	instrOffset := self at: 0 moveCw: srcAddr intoR: RISCTempReg.
	"We *could* overwrite the last instruction above with a LDR a, b, last-byte-of-srcAddr BUT that would break if we change to loading literals instead of forming long constants"
	self machineCodeAt: instrOffset put: (self ldr: destReg rn: RISCTempReg plusImm: 0).
	^machineCodeSize := instrOffset + 4