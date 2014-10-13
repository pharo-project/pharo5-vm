bytecode generators
genPushEnclosingObjectAt: level
	"Uncached push enclosing object"
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: SendNumArgsReg.
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceEnclosingObjectTrampoline.
	^self ssPushRegister: ReceiverResultReg