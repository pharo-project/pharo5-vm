generate machine code - concretize
concretizeMoveMwrR
	"Will get inlined into concretizeAt: switch."
	<var: #offset type: #sqInt>
	<inline: true>
	| srcReg offset destReg instrOffset|
	offset := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteRegister: (operands at: 2).
	self is12BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0 "ldr destReg, [srcReg, #immediate]"
				put: (self ldr: destReg rn: srcReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[instrOffset := self at: 0 moveCw: offset intoR: ConcreteIPReg.
			"ldr destReg, [srcReg, ConcreteIPReg]"
			self machineCodeAt: instrOffset put: (self ldr: destReg rn: srcReg rm: ConcreteIPReg).
			^machineCodeSize := instrOffset + 4].
	^0 "to keep Slang happy"