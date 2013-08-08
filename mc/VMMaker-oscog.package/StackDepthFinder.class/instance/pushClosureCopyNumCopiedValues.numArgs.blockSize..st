instruction decoding
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	"Push Closure bytecode."
	numCopied = 0
		ifTrue: [self push]
		ifFalse: [numCopied > 1 ifTrue:
					[self drop: numCopied - 1]].
	self doJump: blockSize.
	stackp := numCopied + numArgs