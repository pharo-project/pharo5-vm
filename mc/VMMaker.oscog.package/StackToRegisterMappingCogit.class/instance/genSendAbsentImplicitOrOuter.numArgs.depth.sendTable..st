bytecode generators
genSendAbsentImplicitOrOuter: selector numArgs: numArgs depth: depth sendTable: sendTable
	<var: #sendTable type: #'sqInt *'>
	| nsSendCache |
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].

	nsSendCache := theIRCs + (NumOopsPerNSC * objectMemory bytesPerOop * indexOfIRC).
	indexOfIRC := indexOfIRC + 1.
	self assert: (objectMemory isInOldSpace: nsSendCache).
	self initializeNSSendCache: nsSendCache selector: selector numArgs: numArgs depth: depth.

	self ssAllocateCallReg: SendNumArgsReg.

	"This leaves the method receiver on the stack, which might not be the implicit receiver. But we care
	 not: the callee will use ReceiverResultReg to build its frame, not the value beneath the arguments."
	self marshallAbsentReceiverSendArguments: numArgs.

	"Load the cache last so it is a fixed distance from the call."
	self MoveCw: nsSendCache R: SendNumArgsReg.
	self CallNewspeakSend: (sendTable at: (numArgs min: NumSendTrampolines - 1)).

	optStatus isReceiverResultRegLive: false.
	self ssPushRegister: ReceiverResultReg.
	^0