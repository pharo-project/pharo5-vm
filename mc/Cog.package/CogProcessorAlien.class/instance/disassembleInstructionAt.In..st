disassembly
disassembleInstructionAt: pc In: memory
	^(self primitiveDisassembleAt: pc inMemory: memory) last