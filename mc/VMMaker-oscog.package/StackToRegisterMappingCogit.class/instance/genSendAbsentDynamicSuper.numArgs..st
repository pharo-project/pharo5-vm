bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	"OK, we could do better and avoid spilling ReceiverResultReg if we refactored
	 marshallImplicitReceiverSendArguments: to take a flag saying whether the
	 receiver was in ReceiverResultReg (absent receiver send) or on the stack
	 (absent dynamic super send) and in the latter case loading ReceiverResultReg
	 from the stack after marshalling.  But this is a rare bytecode so for the moment
	 don't bother."
	self ssAllocateCallReg: ReceiverResultReg.
	self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg.
	self marshallImplicitReceiverSendArguments: numArgs.
	^self genMarshalledSendDynamicSuper: selector numArgs: numArgs