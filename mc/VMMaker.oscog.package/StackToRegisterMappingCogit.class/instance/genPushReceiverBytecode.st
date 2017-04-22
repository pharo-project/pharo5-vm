bytecode generators
genPushReceiverBytecode
	self receiverIsInReceiverResultReg ifTrue:
		[^self ssPushRegister: ReceiverResultReg].
	self assert: simSelf registerOrNone = NoReg.
	^self ssPushDesc: simSelf