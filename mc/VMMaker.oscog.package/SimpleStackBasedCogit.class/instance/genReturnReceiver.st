bytecode generators
genReturnReceiver
	"Frameless method activation looks like
				receiver
				args
		sp->	ret pc.
	 Return pops receiver and arguments off the stack.  Callee pushes the result."
	needsFrame ifTrue:
		[self putSelfInReceiverResultReg].
	^self genUpArrowReturn