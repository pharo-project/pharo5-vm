disassembly
disassembleInstructionAt: ip In: memory into: aBlock
	| lenAndDi |
	lenAndDi := self primitiveDisassembleAt: ip inMemory: memory.
	^aBlock value: lenAndDi last value: lenAndDi first