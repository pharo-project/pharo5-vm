processor api
disassembleFrom: startAddress to: endAddress in: memory on: aStream
	MIPSDisassembler new 
		disassemble: memory
		from: startAddress
		to: endAddress
		for: nil
		labels: nil
		on: aStream.