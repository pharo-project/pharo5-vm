bytecode generator support
genCreateClosureAt: bcpc numArgs: numArgs numCopied: numCopied contextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock
	"Create a closure with the given startpc, numArgs and numCopied
	 within a context with ctxtNumArgs, large if isLargeCtxt that is in a
	 block if isInBlock.  If numCopied > 0 pop those values off the stack."
	self subclassResponsibility