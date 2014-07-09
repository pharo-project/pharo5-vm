assembly
jumpLong: offsetOrLabel
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	^offset ifNotNil:
		[encoder sizeJumpLong: offset]