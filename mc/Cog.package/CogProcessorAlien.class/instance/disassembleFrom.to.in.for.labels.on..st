disassembly
disassembleFrom: startAddress to: endAddress in: memory for: aSymbolManager "<Cogit>" labels: labelDictionary on: aStream
	| address |
	address := startAddress.
	[address <= endAddress] whileTrue:
		[[:sizeArg :stringArg| | size string |
		  size := sizeArg.
		  string := stringArg.
		  (aSymbolManager labelForPC: address) ifNotNil:
			[:label| aStream nextPutAll: label; nextPut: $:; cr].
		  (labelDictionary at: address ifAbsent: []) ifNotNil:
			[:label|
			self printLabel: label on: aStream at: address for: aSymbolManager.
			label isArray ifTrue:
				[string := nil.
				 size := label third]].
		  string ifNotNil:
			[aStream nextPutAll: (self decorateDisassembly: string for: aSymbolManager fromAddress: address)].
		  aStream cr; flush.
		  address := address + size]
			valueWithArguments: (self
									primitiveDisassembleAt: address
									inMemory: memory)].
	(labelDictionary at: address ifAbsent: []) ifNotNil:
		[:label| self printLabel: label on: aStream at: address for: aSymbolManager]