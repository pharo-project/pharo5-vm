bytecode generators
genReturnReceiver
	"In a frameless method ReceiverResultReg already contains self.
	 In a frameful method, ReceiverResultReg /may/ contain self."
	needsFrame ifTrue:
		[(optStatus isReceiverResultRegLive
		  and: [optStatus ssEntry = (self addressOf: simSelf)]) ifFalse:
			[self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg]].
	^self genUpArrowReturn