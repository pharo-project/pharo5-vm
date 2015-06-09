generate machine code
labelOffset
	"Hack:  To arrange that the block method field pushed in a block entry has
	 its MFMethodFlagIsBlockFlag bit set we provide labels with an offset.  The
	 offset for the fakeHeader reference is MFMethodFlagIsBlockFlag.  See
	 compileBlockFrameBuild:"
	^operands at: 1