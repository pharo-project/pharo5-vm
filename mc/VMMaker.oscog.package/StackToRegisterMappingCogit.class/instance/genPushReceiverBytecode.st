bytecode generators
genPushReceiverBytecode
	optStatus isReceiverResultRegLive ifTrue:
		[^self ssPushRegister: ReceiverResultReg].
	self assert: simSelf registerOrNone = NoReg.
	^self ssPushDesc: simSelf