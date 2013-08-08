trampolines
ceSend: selector super: superNormalBar to: rcvr numArgs: numArgs
	"self stringOf: selector"
	"self printOop: rcvr"
	self logSend: selector.
	cogit assertCStackWellAligned.
	self maybeCheckStackDepth: numArgs + 1 sp: stackPointer pc: (stackPages longAt: stackPointer).
	^super ceSend: selector super: superNormalBar to: rcvr numArgs: numArgs