bytecode generators
genReturnTopFromMethod
	"Return pops receiver and arguments off the stack.  Callee pushes the result."
	self PopR: ReceiverResultReg.
	^self genUpArrowReturn