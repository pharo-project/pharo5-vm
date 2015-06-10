testing
literalInstructionInRange: litInst
	"A literal is in range if its opcode index is within outOfLineLiteralOpcodeLimit, or if
	 its index has yet to be assigned."
	| opcodeIndex |
	opcodeIndex := litInst literalOpcodeIndex.
	^opcodeIndex asInteger < 0
	  or: [self assert cogit opcodeIndex >= opcodeIndex.
		cogit getOpcodeIndex - opcodeIndex < cogit backEnd outOfLineLiteralOpcodeLimit]