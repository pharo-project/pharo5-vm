instruction decoding
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	"Override to add a label for the start of a block."
	labelling ifTrue:
		[labels at: instrs pc put: true].
	super pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize