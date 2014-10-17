assembly
sizePasses
	| sizer instructions lastForwardJump i limit messageOrLabel |
	sizer := BytecodeSizer assembler: self encoder: encoder.
	"Forward pass that sizes all except forward jumps."
	i := 0.
	limit := (instructions := code instructions) size.
	[(i := i + 1) <= limit] whileTrue:
		[messageOrLabel := instructions at: i.
		sizes
			at: i
			put: ((self isLabel: messageOrLabel)
					ifTrue: [0]
					ifFalse: [index := i.
							(messageOrLabel sentTo: sizer)
								ifNil: [lastForwardJump := i. nil]
								ifNotNil: [:size| size]])].
	lastForwardJump ifNil: [^self].
	"Backward pass that sizes forward jumps."
	i := lastForwardJump + 1.
	[(i := i - 1) >= 1] whileTrue:
		[(sizes at: i) ifNil:
			[index := i.
			 sizes
				at: i
				put: ((instructions at: i) sentTo: sizer)]]