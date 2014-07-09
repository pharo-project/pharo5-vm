assembling
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	self checkLabel: blockSize.
	self ensureInstructions addLast: (Message
										selector: #pushClosureCopyNumCopiedValues:numArgs:blockSize:
										arguments: {numCopied. numArgs. blockSize})