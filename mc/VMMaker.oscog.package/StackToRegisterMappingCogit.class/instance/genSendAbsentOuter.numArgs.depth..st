bytecode generators
genSendAbsentOuter: selector numArgs: numArgs depth: depth
	"OK, we could do better and avoid spilling ReceiverResultReg if we refactored
	 marshallAbsentReceiverSendArguments: to take a flag saying whether the
	 receiver was in ReceiverResultReg (absent receiver send) or on the stack
	 (absent dynamic super send) and in the latter case loading ReceiverResultReg
	 from the stack after marshalling.  But this is a rare bytecode so for the moment
	 don't bother."
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: SendNumArgsReg.
	self MoveCq: depth R: SendNumArgsReg.
	self CallRT: ceEnclosingObjectTrampoline.
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: ordinarySendTrampolines