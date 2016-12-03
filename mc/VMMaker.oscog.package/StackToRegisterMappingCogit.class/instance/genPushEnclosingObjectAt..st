bytecode generator support
genPushEnclosingObjectAt: level
	"Uncached push enclosing object"
	self voidReceiverResultRegContainsSelf.
	self ssAllocateCallReg: SendNumArgsReg and: ReceiverResultReg.
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceEnclosingObjectTrampoline.
	^self ssPushRegister: ReceiverResultReg