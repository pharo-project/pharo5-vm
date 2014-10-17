assembly
jump: offsetOrLabel if: condition
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	condition
		ifTrue: [encoder genBranchPopTrue: offset]
		ifFalse: [encoder genBranchPopFalse: offset]