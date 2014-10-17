assembly
storeIntoReceiverVariable: offsetOrName
	| offset |
	offset := offsetOrName isInteger
				ifTrue: [offsetOrName]
				ifFalse: [assembler offsetForInstVarName: offsetOrName].
	"handle context inst var access"
	^(assembler shouldUseLongAccessForInstVarOffset: offset)
		ifTrue: [encoder sizeStoreInstVarLong: offset]
		ifFalse: [encoder sizeStoreInstVar: offset]