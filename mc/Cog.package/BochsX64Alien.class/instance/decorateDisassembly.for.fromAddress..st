disassembly
decorateDisassembly: anInstructionString for: aSymbolManager "<Cogit>" fromAddress: address
	| string i1 i2 v extra |
	string := anInstructionString.
	aSymbolManager relativeBaseForDisassemblyInto:
		[:baseAddress :baseName|
		string := baseName, '+', (address - baseAddress printStringBase: 16 length: 4 padded: true), (string copyFrom: (string indexOf: $:) + 1 to: string size)].
	((i1 := string indexOfSubCollection: '%ds:(') > 0
	or: [(i1 := string indexOfSubCollection: '%ss:(') > 0]) ifTrue:
		[string := string copyReplaceFrom: i1 to: i1 + 3 with: ''].
	(i1 := string indexOfSubCollection: '%ds:0x') > 0 ifTrue:
		[i2 := i1 + 6.
		 ['0123456789abcdef' includes: (string at: i2)] whileTrue: [i2 := i2 + 1].
		 (v := string copyFrom: i2 to: (i2 + 5 min: string size)) = '(%rbx)' ifTrue:
			[v := Integer readFrom: (ReadStream on: string from: i1 + 6 to: i2 - 1) base: 16.
		 	 (aSymbolManager lookupAddress: aSymbolManager varBaseAddress + v) ifNotNil:
				[:varName| extra := ' = ', varName]].
		 v = '(%rip)' ifTrue:
			[v := string size - (string indexOf: $: startingAt: i2 + 5) - 1 / 3. "Count number of instruction bytes to find size of instruction"
			 v := v + address. "Add address of instruction"
			 v := v + (Integer readFrom: (ReadStream on: string from: i1 + 6 to: i2 - 1) base: 16) signedIntFromLong64. "Add offset to yield pc-relative address"
		 	 (aSymbolManager lookupAddress: v) ifNotNil:
				[:methodName| extra := ' = ', methodName]].
		 string := string
					copyReplaceFrom: i1
					to: i2 - 1
					with: (aSymbolManager lookupCHexString: (string copyFrom: i1 + 4 to: i2 - 1))].
	(i1 := string indexOfSubCollection: '%ss:0x') > 0 ifTrue:
		[i2 := i1 + 6.
		 ['0123456789abcdef' includes: (string at: i2)] whileTrue: [i2 := i2 + 1].
		 ((string at: i2) = $(
		 and: [(string at: i2 + 1) = $%]) ifTrue:
			[v := Integer readFrom: (ReadStream on: string from: i1 + 6 to: i2 - 1) base: 16.
			string := string
						copyReplaceFrom: i1
						to: i2 - 1
						with: ((v bitAnd: (1 bitShift: 31) - 1) - (v bitAnd: (1 bitShift: 31))) printString]].
	(i1 := string indexOfSubCollection: '$0x') > 0 ifTrue:
		[i2 := i1 + 3.
		 ['0123456789abcdef' includes: (string at: i2)] whileTrue: [i2 := i2 + 1].
		 string := string
					copyReplaceFrom: i1 + 1
					to: i2 - 1
					with: (aSymbolManager lookupCHexString: (string copyFrom: i1 + 1 to: i2 - 1))].
	((i1 := string indexOf: $() > 1
	 and: [(string at: i1 + 1) isDigit
	 and: [i1 < (i2 := string indexOf: $))]]) ifTrue:
		[string := string
					copyReplaceFrom: i1 + 1
					to: i2 - 1
					with: (aSymbolManager lookupCHexString: (string copyFrom: i1 + 1 to: i2 - 1)).
		 i1 := string indexOfSubCollection: '+0x'. "calls & jumps"
		 i1 > 0 ifTrue:
			[v := Integer readFrom: (i2 := ReadStream on: string from: i1 + 3 to: string size) base: 16.
			 v := ((v bitAnd: (1 bitShift: 63) - 1) - (v bitAnd: (1 bitShift: 63))) printStringRadix: 16.
			 v := v first = $1
					ifTrue: [v copyReplaceFrom: 1 to: 3 with: '+0x']
					ifFalse: [v copyReplaceFrom: 2 to: 4 with: '0x'].
			 string := string copyReplaceFrom: i1 to: i2 position with: v]].
	^extra
		ifNil: [string]
		ifNotNil: [i1 := string lastIndexOf: $:. string copyReplaceFrom: i1 - 1 to: i1 - 2 with: extra]