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
			label isArray
				ifTrue: [label first == #literal
							ifTrue:
								[label size = 4 ifTrue:
									[aStream nextPutAll: label last; nextPut: $:; cr].
								 aStream
									nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
									nextPut: $:; space;
									nextPutAll: ((aSymbolManager objectMemory longAt: address) printStringBase: 16 length: 8 padded: true) asLowercase.
								 (aSymbolManager lookupAddress: (aSymbolManager objectMemory longAt: address)) ifNotNil:
									[:name| aStream space; nextPutAll: name]]
							ifFalse:
								[aStream
									nextPutAll: label first;
									nextPut: $:; cr;
									nextPutAll: (address printStringBase: 16 length: 8 padded: true) asLowercase;
									nextPut: $:; space;
									nextPutAll: (aSymbolManager perform: label second with: address) asString].
						string := nil.
						size := label third]
				ifFalse: [aStream nextPutAll: label; nextPut: $:; cr]].
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
									inMemory: memory)]