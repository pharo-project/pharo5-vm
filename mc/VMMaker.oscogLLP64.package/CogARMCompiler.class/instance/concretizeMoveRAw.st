generate machine code - concretize
concretizeMoveRAw
	"Will get inlined into concretizeAt: switch."
	"LEA ConcreteIPReg
	str srcReg, [ConcreteIPReg]"
	<inline: true>
	| srcReg destAddr instrOffset|
	srcReg := operands at: 0.
	destAddr := operands at: 1.
	(self isAddressRelativeToVarBase: destAddr) ifTrue:
		[self machineCodeAt: 0 put: (self str: srcReg rn: ConcreteVarBaseReg plusImm: destAddr - cogit varBaseAddress).
		 ^machineCodeSize := 4].
	"load the address into ConcreteIPReg"
	instrOffset := self moveCw: destAddr intoR: ConcreteIPReg.
	"We *could* overwrite the last instruction above with a LDR a, b, last-byte-of-srcAddr BUT that would break if we change to loading literals instead of forming long constants"
	self machineCodeAt: instrOffset put: (self str: srcReg rn: ConcreteIPReg plusImm: 0).
	^machineCodeSize := instrOffset + 4