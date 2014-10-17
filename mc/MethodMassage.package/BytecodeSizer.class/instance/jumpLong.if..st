assembly
jumpLong: offsetOrLabel if: condition
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	^offset ifNotNil:
		[condition
			ifTrue: [encoder sizeBranchPopTrueLong: offset]
			ifFalse: [encoder sizeBranchPopFalseLong: offset]]