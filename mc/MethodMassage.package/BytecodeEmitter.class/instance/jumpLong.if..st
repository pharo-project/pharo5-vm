assembly
jumpLong: offsetOrLabel if: condition
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	^condition
		ifTrue: [encoder genBranchPopTrueLong: offset]
		ifFalse: [encoder genBranchPopFalseLong: offset]