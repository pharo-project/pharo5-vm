bytecode generator support
genPushEnclosingObjectAt: level
	"Uncached push enclosing object"
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: SendNumArgsReg and: ReceiverResultReg.
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceEnclosingObjectTrampoline.
	^self ssPushRegister: ReceiverResultReg