disassembly
disassembleOpcodesIn: memory to: aStream
	self processor
		disassembleFrom: opcodes first address
		to: opcodes last address + opcodes last machineCodeSize - 1
		in: (self memoryAsBytes: memory)
		on: aStream