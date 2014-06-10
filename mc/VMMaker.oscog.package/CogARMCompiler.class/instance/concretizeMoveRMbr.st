generate machine code - concretize
concretizeMoveRMbr
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset baseReg instrOffset|
	srcReg := self concreteRegister: (operands at: 0).
	offset := operands at: 1.
	baseReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue: [ :u :immediate | 
			self machineCodeAt: 0 
				"strb 	srcReg, [baseReg, #immediate]"
				put: (self strb: srcReg rn: baseReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse: [ 
			instrOffset := self at: 0 moveCw: offset intoR: RISCTempReg.
			"strb 	srcReg, [baseReg, RISCTempReg]"
			self machineCodeAt: instrOffset put: (self strb: srcReg rn: baseReg rm: RISCTempReg).
			^machineCodeSize := instrOffset + 4 ]