assembly
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSizeOrLabel
	| blockSize |
	blockSize := (assembler isLabel: blockSizeOrLabel)
					ifTrue: [assembler spanToLabel: blockSizeOrLabel]
					ifFalse: [blockSizeOrLabel].
	^blockSize ifNotNil:
		[encoder sizePushClosureCopyNumCopiedValues: numCopied numArgs: numArgs jumpSize: blockSize]