generate machine code - concretize
concretizeMoveMbrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue: [ :u :immediate | 
			self machineCodeAt: 0 
				"ldr destReg, [srcReg, #immediate]"
				put: (self t: 2 o: (16rA bitOr: u <<2) s: 1 rn: srcReg rd: destReg shifterOperand: immediate).
			^machineCodeSize := 4]
		ifFalse: [ 
			self at: 0 moveCw: offset intoR: RISCTempReg.
			"ldr destReg, [srcReg, RISCTempReg]"
			self machineCodeAt: 16 put: (self t: 3 o: 16rE s: 1 rn: srcReg rd: destReg shifterOperand: RISCTempReg).
			^machineCodeSize := 20 ]