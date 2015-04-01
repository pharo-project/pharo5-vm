generate machine code - concretize
concretizeMoveMbrR
	"Will get inlined into concretizeAt: switch."
	"ldrb destReg, [srcReg, #immediate] or ldrb destReg, [srcReg, ConcreteIPReg]"
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "ldrb destReg, [srcReg, #immediate]"
				put: (self ldrb: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[(self isAddressRelativeToVarBase: offset)
				ifTrue:
					[self machineCodeAt: 0 put: (self ldr: ConcreteIPReg rn: ConcreteVarBaseReg plusImm: offset - cogit varBaseAddress).
					 instrOffset := 4]
				ifFalse:
					[instrOffset := self at: 0 moveCw: offset intoR: ConcreteIPReg].
			 "ldrb destReg, [srcReg, ConcreteIPReg]"
			 self machineCodeAt: instrOffset put: (self ldrb: destReg rn: srcReg rm: ConcreteIPReg).
			 ^machineCodeSize := instrOffset + 4]