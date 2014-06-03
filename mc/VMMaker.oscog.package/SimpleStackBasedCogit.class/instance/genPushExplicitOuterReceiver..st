bytecode generators
genPushExplicitOuterReceiver: level
	"Uncached push explicit outer send receiver"
	self assert: needsFrame. "because this should always be followed by a send"
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceExplicitReceiverTrampoline.
	self PushR: ReceiverResultReg.
	^0