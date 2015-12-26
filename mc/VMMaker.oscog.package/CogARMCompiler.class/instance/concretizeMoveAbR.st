generate machine code - concretize
concretizeMoveAbR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcAddr destReg instrOffset|
	srcAddr := operands at: 0.
	destReg := operands at: 1.
	(self isAddressRelativeToVarBase: srcAddr) ifTrue:
		[self machineCodeAt: 0 put: (self ldrb: destReg rn: ConcreteVarBaseReg plus: 1 imm: srcAddr - cogit varBaseAddress).
		 ^machineCodeSize := 4].
	"load the address into ConcreteIPReg"
	instrOffset := self moveCw: srcAddr intoR: ConcreteIPReg.
	"We *could* overwrite the last instruction above with a LDR a, b, last-byte-of-srcAddr BUT that would break if we change to loading literals instead of forming long constants"
	self machineCodeAt: instrOffset put: (self ldrb: destReg rn: ConcreteIPReg plus: 1 imm: 0).
	^machineCodeSize := instrOffset + 4