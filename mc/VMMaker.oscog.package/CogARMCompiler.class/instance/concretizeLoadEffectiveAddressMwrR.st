generate machine code - concretize
concretizeLoadEffectiveAddressMwrR
	"Will get inlined into concretizeAt: switch."
	"destReg = srcReg (which contains an address) + offset"
	<inline: true>
	| srcReg offset destReg instrOffset |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	self rotateable8bitImmediate: offset
		ifTrue:
			[ :rot :immediate | 
			self machineCodeAt: 0 
				"add destReg, srcReg, #immediate ROR rot"
				put: (self add: destReg rn: srcReg imm: immediate ror: rot<<1).
			machineCodeSize := 4]
		ifFalse:
			[instrOffset := self moveCw: offset intoR: ConcreteIPReg.
			"add destReg, srcReg, ConcreteIPReg"
			self machineCodeAt: 16 put: (self add: destReg rn: srcReg rm: ConcreteIPReg).
			machineCodeSize := instrOffset + 4].
	^machineCodeSize "to keep Slang happy"