generate machine code - concretize
concretizeLoadEffectiveAddressMwrR
	"Will get inlined into concretizeAt: switch."
	"destReg = srcReg (which contains an address) + offset"
	<inline: true>
	| srcReg offset destReg instrOffset |
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self rotateable8bitImmediate: offset
		ifTrue: [ :rot :immediate | 
			self machineCodeAt: 0 
				"add destReg, srcReg, #immediate ROR rot"
				put: (self add: destReg rn: srcReg imm: immediate ror: rot<<1).
			^machineCodeSize := 4]
		ifFalse: [ 
			instrOffset := self at: 0 moveCw: offset intoR: RISCTempReg.
			"add destReg, srcReg, RISCTempReg"
			self machineCodeAt: 16 put: (self add: destReg rn: srcReg rm: RISCTempReg).
			^machineCodeSize := instrOffset + 4 ]