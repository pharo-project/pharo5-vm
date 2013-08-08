documentation
callingConvention
	"The Smalltalk-to-Smalltalk calling convention for SimpleStackBasedCogit is
	 designed to be congruent with the interpreter and convenient for inline cacheing.
	 For inline cacheing it is convenient if the receiver is in a register.

	 Hence the calling convention is:
	
		On call ReceiverResultReg (edx on x86) contains the receiver, and the receiver
		and arguments are all on the stack, receiver furthest from top-of-stack.
	
		If the number of arguments is 3 or greater then the argument count is passed in
		SendNumArgsReg (this is for the linking run-time routine; it is ignored in linked sends).

		On return result is in ReceiverResultReg.  The callee removes arguments from the stack.
		The caller pushes the result if the result is used."