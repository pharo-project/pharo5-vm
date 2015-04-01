generate machine code - concretize
concretizeMoveM16rR
	"Will get inlined into concretizeAt: switch."
	"ldrh destReg, [srcReg, #immediate],
	or 
	move offset to ConcreteIPReg
	ldrh destReg, [srcReg, ConcreteIPReg]"
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self is8BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "ldrh destReg, [srcReg, #immediate]"
				put: (self ldrh: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[instrOffset := self at: 0 moveCw: offset intoR: ConcreteIPReg.
			"ldrh destReg, [srcReg, ConcreteIPReg]"
			self machineCodeAt: instrOffset put: (self ldrh: destReg rn: srcReg rm: ConcreteIPReg).
			^machineCodeSize := instrOffset + 4 ]