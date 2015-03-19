disassembly
disassembleNextInstructionIn: memory for: aSymbolManager "<Cogit|nil>"
	| string |
	string := self pc < memory size 
				ifTrue: [(self primitiveDisassembleAt: self pc inMemory: memory) last.]
				ifFalse: [string := aSymbolManager ifNotNil:
									[aSymbolManager lookupAddress: self pc].
						 ^self pc hex, ' : ', (string ifNil: ['Invalid address'])].
	^aSymbolManager
		ifNil: [string]
		ifNotNil: [self decorateDisassembly: string for: aSymbolManager fromAddress: self pc]