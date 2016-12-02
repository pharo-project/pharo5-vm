bytecode generators
genPushReceiverBytecode
	optStatus isReceiverResultRegLive ifTrue:
		[^self ssPushRegister: ReceiverResultReg].
	self assert: simSelf liveRegister = NoReg.
	^self ssPushDesc: simSelf