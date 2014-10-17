instruction decoding
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	labelling
		ifTrue:
			[labels at: instrs pc + blockSize put: true]
		ifFalse:
			[instructions
				at: thePC
				put: (Message
						selector: #pushClosureCopyNumCopiedValues:numArgs:blockSize:
						arguments: { numCopied. numArgs. labels at: instrs pc + blockSize })]