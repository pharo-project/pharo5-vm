bytecode generators
genPushReceiverBytecode
	(optStatus isReceiverResultRegLive
	  and: [optStatus ssEntry = (self addressOf: simSelf)]) ifTrue:
		[^self ssPushRegister: ReceiverResultReg].
	^self ssPushDesc: simSelf