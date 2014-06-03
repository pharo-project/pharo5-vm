abi
leafCallStackPointerDelta
	"Answer the delta from the stack pointer after a call to the stack pointer
	 immediately prior to the call.  This is used to compute the stack pointer
	 immediately prior to  call from within a leaf routine, which in turn is used
	 to capture the c stack pointer to use in trampolines back into the C run-time."
	"This might actually be false, since directly after a call, lr, fp and variable registers need be pushed onto the stack. It depends on the implementation of call."
	^0