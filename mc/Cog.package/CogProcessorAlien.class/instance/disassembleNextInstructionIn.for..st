disassembly
disassembleNextInstructionIn: memory for: aSymbolManager "<Cogit|nil>"
	| string |
	string := self pc < memory size 
				ifTrue: [(self primitiveDisassembleAt: self pc inMemory: memory) last.]
				ifFalse: ['Invalid address (', (self pc hex allButFirst: 3), ')'].
	^aSymbolManager
		ifNil: [string]
		ifNotNil: [self decorateDisassembly: string for: aSymbolManager]