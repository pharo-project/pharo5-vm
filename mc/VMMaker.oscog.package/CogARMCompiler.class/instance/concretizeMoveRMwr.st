generate machine code - concretize
concretizeMoveRMwr
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset baseReg instrOffset|
	srcReg := self concreteRegister: (operands at: 0).
	offset := operands at: 1.
	baseReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue: [ :u :immediate | 
			self machineCodeAt: 0 
				"str 	srcReg, [baseReg, #immediate]"
				put: (self str: srcReg rn: baseReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse: [ 
			instrOffset := self at: 0 moveCw: offset intoR: RISCTempReg.
			"str srcReg, [baseReg, RISCTempReg]"
			self machineCodeAt: instrOffset put: (self str: srcReg rn: baseReg rm: RISCTempReg).
			^machineCodeSize := instrOffset + 4 ]