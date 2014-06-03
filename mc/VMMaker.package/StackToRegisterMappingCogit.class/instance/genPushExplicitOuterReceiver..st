bytecode generators
genPushExplicitOuterReceiver: level
	"Uncached push explicit outer send receiver"
	self assert: needsFrame. "because this should always be followed by a send"
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: SendNumArgsReg.
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceExplicitReceiverTrampoline.
	^self ssPushRegister: ReceiverResultReg