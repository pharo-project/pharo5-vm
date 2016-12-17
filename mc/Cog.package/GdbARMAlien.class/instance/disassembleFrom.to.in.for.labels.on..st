disassembly
disassembleFrom: startAddress to: endAddress in: memory for: aSymbolManager "<Cogit>" labels: labelDictionary on: aStream
	| address |
	address := startAddress.
	[address <= endAddress] whileTrue:
		[[:sizeArg :stringArg| | size string index offset |
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
			[aStream nextPutAll: (self decorateDisassembly: string for: aSymbolManager fromAddress: address).
			 (string includesSubString: ': ldr	') ifTrue:"i.e. colon space 'ldr' tab" 
				[(index := string indexOfSubCollection: ' [pc, #' startingAt: 1) > 0
					ifTrue:
						[offset := Integer readFrom: (ReadStream on: string from: index + 7 to: (string indexOf: $] startingAt: index + 7) - 1)]
					ifFalse:
						[(string indexOfSubCollection: ' [pc]' startingAt: 1) > 0 ifTrue:
							[offset := 0]].
				 offset ifNotNil:
					[offset := address + 8 + offset.
					 labelDictionary
						at: offset
						ifPresent:
							[:entry|
							entry isString
								ifTrue: [labelDictionary at: offset put: {#literal. offset. 4. entry}]
								ifFalse: [self assert: (entry isArray and: [entry first == #literal])]]
						ifAbsentPut: [{#literal. offset. 4}]]]].
		aStream cr; flush.
		address := address + size]
			valueWithArguments: (self
									primitiveDisassembleAt: address
									inMemory: memory)].
	(labelDictionary at: address ifAbsent: []) ifNotNil:
		[:label| self printLabel: label on: aStream at: address for: aSymbolManager]