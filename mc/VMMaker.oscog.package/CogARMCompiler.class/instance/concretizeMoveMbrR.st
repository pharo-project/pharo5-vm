generate machine code - concretize
concretizeMoveMbrR
	"Will get inlined into concretizeAt: switch."
	"ldrb destReg, [srcReg, #immediate] or ldrb destReg, [srcReg, ConcreteIPReg]"
	<var: #offset type: #sqInt>
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	self is12BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "ldrb destReg, [srcReg, #immediate]"
				put: (self ldrb: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[(self isAddressRelativeToVarBase: offset)
				ifTrue:
					[self machineCodeAt: 0 put: (self adds: ConcreteIPReg rn: ConcreteVarBaseReg imm: offset - cogit varBaseAddress ror: 0).
					 instrOffset := 4]
				ifFalse:
					[instrOffset := self moveCw: offset intoR: ConcreteIPReg].
			 "ldrb destReg, [srcReg, ConcreteIPReg]"
			 self machineCodeAt: instrOffset put: (self ldrb: destReg rn: srcReg rm: ConcreteIPReg).
			 ^machineCodeSize := instrOffset + 4].
	^0 "to keep Slang happy"