generate machine code - concretize
concretizeMoveM16rR
	"Will get inlined into concretizeAt: switch."
	"ldrh destReg, [srcReg, #immediate],
	or 
	move offset to ConcreteIPReg
	ldrh destReg, [srcReg, ConcreteIPReg]"
	<var: #offset type: #sqInt>
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	self is8BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "ldrh destReg, [srcReg, #immediate]"
				put: (self ldrh: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[instrOffset := self moveCw: offset intoR: ConcreteIPReg.
			"ldrh destReg, [srcReg, ConcreteIPReg]"
			self machineCodeAt: instrOffset put: (self ldrh: destReg rn: srcReg rm: ConcreteIPReg).
			^machineCodeSize := instrOffset + 4 ].
	^0 "to keep Slang happy"