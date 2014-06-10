compile abstract instructions
gen: opcode "<Integer>"
	| abstractInstruction |
	<inline: false>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	self assert: opcodeIndex < numAbstractOpcodes.
	abstractInstruction := self abstractInstructionAt: opcodeIndex.
	opcodeIndex := opcodeIndex + 1.
	abstractInstruction opcode: opcode.
	self cCode: '' inSmalltalk: [abstractInstruction bcpc: bytecodePC].
	^abstractInstruction