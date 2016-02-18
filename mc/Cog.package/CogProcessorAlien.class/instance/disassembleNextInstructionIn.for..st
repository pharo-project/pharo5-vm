disassembly
disassembleNextInstructionIn: memory for: aSymbolManager "<Cogit|nil>"
	| arrayOfLengthAndString |
	self pc >= memory size ifTrue:
		[| string |
		 string := aSymbolManager ifNotNil:
									[aSymbolManager lookupAddress: self pc].
		 ^self pc hex, ' : ', (string ifNil: ['Invalid address'])].
	arrayOfLengthAndString := self primitiveDisassembleAt: self pc inMemory: memory.
	(arrayOfLengthAndString isArray
	and: [arrayOfLengthAndString first isInteger
	and: [arrayOfLengthAndString last isString]]) ifFalse:
		[^'ERROR: ', (arrayOfLengthAndString printString contractTo: 40)].
	^aSymbolManager
		ifNil: [arrayOfLengthAndString last]
		ifNotNil: [self decorateDisassembly: arrayOfLengthAndString last for: aSymbolManager fromAddress: self pc]