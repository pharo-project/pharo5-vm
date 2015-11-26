processor api
disassembleFrom: startAddress to: endAddress in: memory for: aSymbolManager "<Cogit>" labels: labelDictionary on: aStream
	MIPSDisassembler new 
		disassemble: memory
		from: startAddress
		to: endAddress
		for: aSymbolManager
		labels: labelDictionary
		on: aStream.