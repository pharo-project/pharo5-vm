bytecode generators
genPushEnclosingObjectAt: level
	"Uncached push enclosing object"
	self MoveCq: level R: SendNumArgsReg.
	self CallRT: ceEnclosingObjectTrampoline.
	self PushR: ReceiverResultReg.
	^0