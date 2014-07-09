assembly
popIntoReceiverVariable: offsetOrName
	| offset |
	offset := offsetOrName isInteger
				ifTrue: [offsetOrName]
				ifFalse: [assembler offsetForInstVarName: offsetOrName].
	"handle context inst var access"
	^(assembler shouldUseLongAccessForInstVarOffset: offset)
		ifTrue: [encoder sizeStorePopInstVarLong: offset]
		ifFalse: [encoder sizeStorePopInstVar: offset]