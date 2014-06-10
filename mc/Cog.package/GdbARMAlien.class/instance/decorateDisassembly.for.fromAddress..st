disassembly
decorateDisassembly: anInstructionString for: aSymbolManager "<Cogit>" fromAddress: address
	(anInstructionString endsWith: 'mov	r0, r0')
		ifTrue: [^super decorateDisassembly: 'nop' for: aSymbolManager].
	^super decorateDisassembly: anInstructionString for: aSymbolManager