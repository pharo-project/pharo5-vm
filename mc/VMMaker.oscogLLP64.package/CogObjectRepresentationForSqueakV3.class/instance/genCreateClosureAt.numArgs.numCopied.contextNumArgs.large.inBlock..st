bytecode generator support
genCreateClosureAt: bcpc numArgs: numArgs numCopied: numCopied contextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock
	"Create a closure with the given startpc, numArgs and numCopied
	 within a context with ctxtNumArgs, large if isLargeCtxt that is in a
	 block if isInBlock.  If numCopied > 0 pop those values off the stack."
	
	"see ceClosureCopyDescriptor:"
	cogit MoveCq: numArgs + (numCopied << 6) + (bcpc << 12) R: SendNumArgsReg.
	cogit CallRT: ceClosureCopyTrampoline.
	numCopied > 0 ifTrue:
		[cogit AddCq: numCopied * objectMemory wordSize R: SPReg].
	^0