bytecode generators
genNSSend: selectorIndex numArgs: numArgs depth: depth sendTable: sendTable
	<var: #sendTable type: #'sqInt *'>
	| selector nsSendCache |
	self assert: (selectorIndex between: 0 and: (objectMemory literalCountOf: methodObj) - 1).
	selector := self getLiteral: selectorIndex.
	self assert: (objectMemory addressCouldBeOop: selector).	
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].

	nsSendCache := theIRCs + (NumOopsPerNSC * objectMemory bytesPerOop * indexOfIRC).
	indexOfIRC := indexOfIRC + 1.
	self assert: (objectMemory isInOldSpace: nsSendCache).
	self initializeNSSendCache: nsSendCache selector: selector numArgs: numArgs depth: depth.

	self ssAllocateCallReg: SendNumArgsReg.

	"This may leave the method receiver on the stack, which might not be the implicit receiver.
	 But the lookup trampoline will establish an on-stack receiver once it locates it."
	self marshallAbsentReceiverSendArguments: numArgs.

	"Load the cache last so it is a fixed distance from the call."
	self MoveUniqueCw: nsSendCache R: SendNumArgsReg.
	self CallNewspeakSend: (sendTable at: (numArgs min: NumSendTrampolines - 1)).

	optStatus isReceiverResultRegLive: false.
	self ssPushRegister: ReceiverResultReg.
	^0