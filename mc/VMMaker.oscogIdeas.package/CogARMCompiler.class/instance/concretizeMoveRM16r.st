generate machine code - concretize
concretizeMoveRM16r
	"Will get inlined into concretizeAt: switch."
	<var: #offset type: #sqInt>
	<inline: true>
	| srcReg offset baseReg instrOffset|
	srcReg := operands at: 0.
	offset := operands at: 1.
	baseReg := operands at: 2.
	self is12BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "strh 	srcReg, [baseReg, #immediate]"
				put: (self strh: srcReg rn: baseReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[(self isAddressRelativeToVarBase: offset)
				ifTrue:
					[self machineCodeAt: 0 put: (self adds: ConcreteIPReg rn: ConcreteVarBaseReg imm: offset - cogit varBaseAddress ror: 0).
					 instrOffset := 4]
				ifFalse:
					[instrOffset := self moveCw: offset intoR: ConcreteIPReg].
			"strb 	srcReg, [baseReg, ConcreteIPReg]"
			self machineCodeAt: instrOffset put: (self strh: srcReg rn: baseReg rm: ConcreteIPReg).
			^machineCodeSize := instrOffset + 4 ].
	^0 "to keep Slang happy"