trampolines
ceSendAbort: selector to: rcvr numArgs: numArgs
	"self stringOf: selector"
	"self printOop: rcvr"
	self logSend: selector.
	cogit assertCStackWellAligned.
	self maybeCheckStackDepth: (selector = (objectMemory splObj: SelectorAboutToReturn)
										ifTrue: [numArgs]
										ifFalse: [numArgs + 1])
		sp: stackPointer + objectMemory wordSize
		pc: (stackPages longAt: stackPointer).
	^super ceSendAbort: selector to: rcvr numArgs: numArgs