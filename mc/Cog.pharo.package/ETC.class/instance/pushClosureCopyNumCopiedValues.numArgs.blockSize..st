instruction decoding
pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize
	"Push Closure bytecode.  Either compute the end of the block if this is
	 the block we're analysing, or skip it, adjusting the stack as appropriate."
	| blockClosure j |
	blockEndStack addLast: blockEnd.
	blockEnd := scanner pc + blockSize.
	contextStack addLast: currentContext.
	currentContext
		pc: scanner pc;
		pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize.
	blockClosure := currentContext top.
	currentContext := blockClosure asContext.
	1 to: numArgs do:
		[:i| currentContext push: 'blkarg', i printString].
	1 to: numCopied do:
		[:i| currentContext push: (blockClosure at: i)].
	j := numArgs + numCopied.
	[scanner willPushNil] whileTrue:
		[scanner interpretNextInstructionFor: self.
		 currentContext at: currentContext stackPtr put: 'blktmp', (j := j + 1) printString]

	"ETC sendsForMethod: (ETC compiledMethodAt: #pushClosureCopyNumCopiedValues:numArgs:blockSize:)"