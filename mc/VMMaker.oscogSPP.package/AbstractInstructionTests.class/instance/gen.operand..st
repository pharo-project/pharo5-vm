generating machine code
gen: opcode operand: operandOne
	| abstractInstruction |
	abstractInstruction := self concreteCompilerClass new.
	abstractInstruction
		opcode: opcode;
		cogit: self.
	abstractInstruction operands at: 0 put: operandOne.
	^opcodes ifNil: [abstractInstruction] ifNotNil: [opcodes addLast: abstractInstruction]