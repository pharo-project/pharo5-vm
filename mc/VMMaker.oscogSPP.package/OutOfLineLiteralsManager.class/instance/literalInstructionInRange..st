testing
literalInstructionInRange: litInst
	"A literal is in range if its opcode index is within outOfLineLiteralOpcodeLimit,
	 or if its index has yet to be assigned."
	<var: 'litInst' type: #'AbstractInstruction *'>
	| opcodeIdx |
	opcodeIdx := litInst literalOpcodeIndex.
	^opcodeIdx asInteger < 0
	  or: [self assert: cogit getOpcodeIndex >= opcodeIdx.
		cogit getOpcodeIndex - opcodeIdx < cogit backEnd outOfLineLiteralOpcodeLimit]