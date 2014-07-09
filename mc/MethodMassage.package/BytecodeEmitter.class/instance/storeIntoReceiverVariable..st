assembly
storeIntoReceiverVariable: offsetOrName
	| offset |
	offset := offsetOrName isInteger
				ifTrue: [offsetOrName]
				ifFalse: [assembler offsetForInstVarName: offsetOrName].
	"handle context inst var access"
	^(assembler shouldUseLongAccessForInstVarOffset: offset)
		ifTrue: [encoder genStoreInstVarLong: offset]
		ifFalse: [encoder genStoreInstVar: offset]