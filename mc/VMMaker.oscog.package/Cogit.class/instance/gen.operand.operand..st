compile abstract instructions
gen: opcode "<Integer>" operand: operandOne "<Integer|CogAbstractInstruction>" operand: operandTwo "<Integer|CogAbstractInstruction>"
	| abstractInstruction |
	<inline: false>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	self assert: opcodeIndex < numAbstractOpcodes.
	abstractInstruction := self abstractInstructionAt: opcodeIndex.
	opcodeIndex := opcodeIndex + 1.
	abstractInstruction opcode: opcode.
	abstractInstruction operands at: 0 put: operandOne.
	abstractInstruction operands at: 1 put: operandTwo.
	self cCode: '' inSmalltalk: [abstractInstruction bcpc: bytecodePC].
	^abstractInstruction