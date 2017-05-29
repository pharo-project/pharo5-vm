abi
leafCallStackPointerDelta
	"Answer the delta from the stack pointer after a call to the stack pointer
	 immediately prior to the call.  This is used to compute the stack pointer
	 immediately prior to  call from within a leaf routine, which in turn is used
	 to capture the c stack pointer to use in trampolines back into the C run-time."
	^8