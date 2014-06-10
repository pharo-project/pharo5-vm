generate machine code - concretize
concretizeMoveRAw
	"Will get inlined into concretizeAt: switch."
	"LEA RISCTempReg
	str srcReg, [RISCTempReg]"
	<inline: true>
	| srcReg destAddr instrOffset|
	srcReg := self concreteRegister: (operands at: 0).
	destAddr := operands at: 1.
	"load the address into RISCTempReg"
	instrOffset := self at: 0 moveCw: destAddr intoR: RISCTempReg.
	"We *could* overwrite the last instruction above with a LDR a, b, last-byte-of-srcAddr BUT that would break if we change to loading literals instead of forming long constants"
	self machineCodeAt: instrOffset put: (self str: srcReg rn: RISCTempReg plusImm: 0).
	^machineCodeSize := instrOffset + 4