disassembly
decorateDisassembly: anInstructionString for: aSymbolManager "<Cogit>" fromAddress: address
	(anInstructionString endsWith: 'mov	r1, r1')
		ifTrue: [^super decorateDisassembly: 'nop' for: aSymbolManager].
	^super decorateDisassembly: anInstructionString for: aSymbolManager