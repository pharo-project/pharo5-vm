generate machine code
setLabelOffset: aValue
	"Hack:  To arrange that the block method field pushed in a block entry has
	 its MFMethodFlagIsBlockFlag bit set we provide labels with an offset.  The
	 offset for the fakeHeader reference is MFMethodFlagIsBlockFlag.  See
	 compileBlockFrameBuild:"
	<inline: true>
	^operands at: 1 put: aValue