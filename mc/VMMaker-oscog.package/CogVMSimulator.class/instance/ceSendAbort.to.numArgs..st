trampolines
ceSendAbort: selector to: rcvr numArgs: numArgs
	"self stringOf: selector"
	"self printOop: rcvr"
	self logSend: selector.
	cogit assertCStackWellAligned.
	self maybeCheckStackDepth: 0 sp: stackPointer pc: (stackPages longAt: stackPointer).
	^super ceSendAbort: selector to: rcvr numArgs: numArgs