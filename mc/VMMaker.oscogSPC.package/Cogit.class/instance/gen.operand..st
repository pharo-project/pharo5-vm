compile abstract instructions
gen: opcode "<Integer>" operand: operand "<Integer|CogAbstractInstruction>"
	| abstractInstruction |
	<inline: false>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	self assert: opcodeIndex < numAbstractOpcodes.
	abstractInstruction := self abstractInstructionAt: opcodeIndex.
	opcodeIndex := opcodeIndex + 1.
	abstractInstruction opcode: opcode.
	abstractInstruction operands at: 0 put: operand.
	self cCode: '' inSmalltalk: [abstractInstruction bcpc: bytecodePC].
	^abstractInstruction