bytecode generators
genReturnTopFromMethod
	"Return pops receiver and arguments off the stack.  Callee pushes the result."
	self flag: 'currently caller pushes result'.
	self PopR: ReceiverResultReg.
	^self genUpArrowReturn