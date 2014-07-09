assembly
pushReceiverVariable: offsetOrName
	| offset |
	offset := offsetOrName isInteger
				ifTrue: [offsetOrName]
				ifFalse: [assembler offsetForInstVarName: offsetOrName].
	"handle context inst var access"
	^(assembler shouldUseLongAccessForInstVarOffset: offset)
		ifTrue: [encoder genPushInstVarLong: offset]
		ifFalse: [encoder genPushInstVar: offset]