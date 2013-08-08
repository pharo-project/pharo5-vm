disassembly
disassembleFrom: startAddress to: endAddress in: memory on: aStream
	| address |
	address := startAddress.
	[address < endAddress] whileTrue:
		[[:size :string|
		aStream nextPutAll: (address printStringBase: 16 length: 8 padded: true); nextPut: $:; tab; tab; nextPutAll: string; cr; flush.
		address := address + size]
			valueWithArguments: (self
									primitiveDisassembleAt: address
									inMemory: memory)]