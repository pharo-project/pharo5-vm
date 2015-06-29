bytecode generator support
genOutlineClosure: startpc numArgs: numArgs numCopied: numCopied
	<inline: true>
	numCopied > 0 ifTrue:
		[self ssFlushTo: simStackPtr].
	optStatus isReceiverResultRegLive: false.
	objectRepresentation getActiveContextAllocatesInMachineCode
		ifTrue: [self ssAllocateCallReg: ReceiverResultReg
					and: SendNumArgsReg
					and: ClassReg]
		ifFalse: [self ssAllocateCallReg: SendNumArgsReg
					and: ReceiverResultReg].
	objectRepresentation
		genCreateClosureAt: startpc + 1 "1 relative"
		numArgs: numArgs
		numCopied: numCopied
		contextNumArgs: methodOrBlockNumArgs
		large: (coInterpreter methodNeedsLargeContext: methodObj)
		inBlock: inBlock.
	numCopied > 0 ifTrue:
		[self ssPop: numCopied].
	self ssPushRegister: ReceiverResultReg
