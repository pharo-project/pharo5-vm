bytecode generators
genPushReceiverBytecode
	optStatus isReceiverResultRegLive ifTrue:
		[^self ssPushRegister: ReceiverResultReg].
	^self ssPushDesc: simSelf