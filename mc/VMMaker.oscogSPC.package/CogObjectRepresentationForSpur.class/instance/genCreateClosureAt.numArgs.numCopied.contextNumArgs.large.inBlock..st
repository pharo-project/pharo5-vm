bytecode generator support
genCreateClosureAt: bcpc numArgs: numArgs numCopied: numCopied contextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock
	"Create a closure with the given startpc, numArgs and numCopied
	 within a context with ctxtNumArgs, large if isLargeCtxt that is in a
	 block if isInBlock.  If numCopied > 0 pop those values off the stack."
	self genNoPopCreateClosureAt: bcpc
		numArgs: numArgs
		numCopied: numCopied
		contextNumArgs: ctxtNumArgs
		large: isLargeCtxt
		inBlock: isInBlock.
	1 to: numCopied do:
		[:i|
		cogit
			PopR: TempReg;
			MoveR: TempReg
				Mw: numCopied - i + ClosureFirstCopiedValueIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize
					r: ReceiverResultReg].
	^0