as yet unclassified
disassemble: memory from: startPC to: limitPC for: aSymbolManager "<Cogit>" labels: labelDictionary on: aStream
	pc := startPC.
	[pc < limitPC] whileTrue:
		[ | word instruction |
		pc printOn: aStream base: 16 nDigits: 8.
		aStream space; space.
		word := memory unsignedLongAt: pc + 1.
		word printOn: aStream base: 16 nDigits: 8.
		aStream space; space.
		instruction := MIPSInstruction new value: word.
		aStream nextPutAll: (instruction decodeFor: self).

		aSymbolManager ifNotNil: [
			(aSymbolManager labelForPC: pc) ifNotNil:
				[:label | aStream nextPutAll: ' ;'; nextPutAll: label]].
		"aStream print: (aSymbolManager lookupAddress: pc)."

		aStream cr.
		pc := pc + OneInstruction].