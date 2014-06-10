generate machine code - concretize
concretizeMoveMbrR
	"Will get inlined into concretizeAt: switch."
	"ldrb destReg, [srcReg, #immediate] or ldrb destReg, [srcReg, RISCTempReg]"
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue: [ :u :immediate | 
			self machineCodeAt: 0 
				"ldrb destReg, [srcReg, #immediate]"
				put: (self ldrb: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse: [ 
			instrOffset := self at: 0 moveCw: offset intoR: RISCTempReg.
			"ldrb destReg, [srcReg, RISCTempReg]"
			self machineCodeAt: instrOffset put: (self ldrb: destReg rn: srcReg rm: RISCTempReg).
			^machineCodeSize := instrOffset + 4 ]