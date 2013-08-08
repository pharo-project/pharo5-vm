bytecode generators
genPushActiveContextBytecode
	self assert: needsFrame.
	self CallRT: ceActiveContextTrampoline.
	self PushR: ReceiverResultReg.
	^0