disassembly
disassembleNextInstructionIn: memory
	^(self primitiveDisassembleAt: self pc inMemory: memory) last