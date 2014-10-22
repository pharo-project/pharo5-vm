instruction decoding
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	self print: 'closureNumCopied: ', numCopied printString
			, ' numArgs: ', numArgs printString
			, ' bytes ', scanner pc printString
			, ' to ', (scanner pc + blockSize - 1) printString.
	innerIndents
		atAll: (scanner pc to: scanner pc + blockSize - 1)
		put: (innerIndents at: scanner pc - 1) + 1