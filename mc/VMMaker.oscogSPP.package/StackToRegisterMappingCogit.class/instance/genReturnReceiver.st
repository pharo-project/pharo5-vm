bytecode generators
genReturnReceiver
	"In a frameless method ReceiverResultReg already contains self.
	 In a frameful method, ReceiverResultReg /may/ contain self."
	needsFrame ifTrue:
		[ optStatus isReceiverResultRegLive ifFalse:
			[self putSelfInReceiverResultReg]].
	^self genUpArrowReturn