generating machine code
gen: opcode operand: operandOne operand: operandTwo
	| abstractInstruction |
	abstractInstruction := self concreteCompilerClass new.
	abstractInstruction
		opcode: opcode;
		cogit: self.
	abstractInstruction operands at: 0 put: operandOne.
	abstractInstruction operands at: 1 put: operandTwo.
	^opcodes ifNil: [abstractInstruction] ifNotNil: [opcodes addLast: abstractInstruction]