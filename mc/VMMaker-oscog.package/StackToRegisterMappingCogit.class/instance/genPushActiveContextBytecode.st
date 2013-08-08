bytecode generators
genPushActiveContextBytecode
	self assert: needsFrame.
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: ReceiverResultReg.
	self CallRT: ceActiveContextTrampoline.
	^self ssPushRegister: ReceiverResultReg