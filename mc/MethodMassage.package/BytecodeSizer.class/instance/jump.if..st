assembly
jump: offsetOrLabel if: condition
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	^offset ifNotNil:
		[condition
			ifTrue: [encoder sizeBranchPopTrue: offset]
			ifFalse: [encoder sizeBranchPopFalse: offset]]