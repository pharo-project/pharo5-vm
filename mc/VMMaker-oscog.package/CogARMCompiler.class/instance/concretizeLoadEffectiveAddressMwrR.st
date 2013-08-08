generate machine code - concretize
concretizeLoadEffectiveAddressMwrR
	"Will get inlined into concretizeAt: switch."
	"destReg = destReg + offset"
	<inline: true>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self rotateable8bitImmediate: offset
		ifTrue: [ :rot :immediate | 
			self machineCodeAt: 0 
				"add destReg, srcReg, #immediate"
				put: (self t: 1 o: 4 s: 0 rn: srcReg rd: destReg shifterOperand: (rot <<8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: [ 
			self at: 0 moveCw: offset intoR: RISCTempReg.
			"add destReg, srcReg, RISCTempReg"
			self machineCodeAt: 16 put: (self t: 0 o: 4 s: 0 rn: srcReg rd: destReg shifterOperand: RISCTempReg).
			^machineCodeSize := 20 ]