generate machine code - concretize
concretizeMoveRMwr
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	srcReg := self concreteRegister: (operands at: 0).
	offset := operands at: 1.
	destReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue: [ :u :immediate | 
			self machineCodeAt: 0 
			"strb 	destReg, [srcReg, #immediate]"
				put: (self t: 2 o: (8 bitOr: u<<2) s: 0 rn: destReg rd: srcReg shifterOperand: immediate).
			^machineCodeSize := 4]
		ifFalse: [ 
			self at: 0 moveCw: offset intoR: RISCTempReg.
			"strb 	destReg, [srcReg, RISCTempReg]"
			self machineCodeAt: 16 put: (self t: 3 o: 16rC s: 0 rn: srcReg rd: destReg shifterOperand: RISCTempReg).
			^machineCodeSize := 20 ]