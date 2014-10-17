assembly
jump: offsetOrLabel
	| offset |
	offset := (assembler isLabel: offsetOrLabel)
				ifTrue: [assembler spanToLabel: offsetOrLabel]
				ifFalse: [offsetOrLabel].
	^offset
		ifNotNil: [encoder sizeJump: offset]
		ifNil: ["If this is a backward jump that is as-yet unsized, answer the long backward jump size.
			   c.f. e.g. MessageNode>>#sizeCodeForWhile:value:"
			  offsetOrLabel value <= assembler index ifTrue:
				[encoder sizeJumpLong: -1]]