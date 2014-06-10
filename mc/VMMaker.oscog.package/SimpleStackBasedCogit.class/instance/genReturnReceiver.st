bytecode generators
genReturnReceiver
	"Frameless method activation looks like
				receiver
				args
		sp->	ret pc.
	 Return pops receiver and arguments off the stack.  Callee pushes the result."
	self flag: 'currently caller pushes result'.
	needsFrame ifTrue:
		[self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg].
	^self genUpArrowReturn