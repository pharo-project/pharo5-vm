trampolines
ceSend: selector super: superNormalBar to: rcvr numArgs: numArgs
	"self stringOf: selector"
	"self printOop: rcvr"
	"(superNormalBar ~= 0 and: [(self stringOf: selector) = #bitShift:]) ifTrue:
		[self halt]."
	self logSend: selector.
	cogit assertCStackWellAligned.
	self maybeCheckStackDepth: numArgs + 1 sp: stackPointer pc: (stackPages longAt: stackPointer).
	^super ceSend: selector super: superNormalBar to: rcvr numArgs: numArgs