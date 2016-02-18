as yet unclassified
currentInstruction
	^[(MIPSDisassembler new disassemble: memory from: pc to: pc + 4)]
		ifError: ['Cannot disassemble', String cr].