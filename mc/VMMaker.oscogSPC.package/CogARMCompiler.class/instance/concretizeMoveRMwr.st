generate machine code - concretize
concretizeMoveRMwr
	"Will get inlined into concretizeAt: switch."
	<var: #offset type: #sqInt>
	<inline: true>
	| srcReg offset baseReg instrOffset|
	srcReg := operands at: 0.
	offset := operands at: 1.
	baseReg := operands at: 2.
	self is12BitValue: offset
		ifTrue:
			[ :u :immediate | 
			self machineCodeAt: 0  "str 	srcReg, [baseReg, #immediate]"
				put: (self str: srcReg rn: baseReg plus: u imm: immediate).
			^machineCodeSize := 4]
		ifFalse:
			[instrOffset := self moveCw: offset intoR: ConcreteIPReg.
			"str srcReg, [baseReg, ConcreteIPReg]"
			self machineCodeAt: instrOffset put: (self str: srcReg rn: baseReg rm: ConcreteIPReg).
			^machineCodeSize := instrOffset + 4].
	^0 "to keep Slang happy"