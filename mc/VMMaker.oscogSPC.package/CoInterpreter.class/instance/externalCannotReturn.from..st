return bytecodes
externalCannotReturn: resultOop from: aContext
	<inline: true>
	self push: aContext.
	self push: resultOop.
	"Both ceBaseFrameReturnTrampoline & ceNonLocalReturnTrampoline pop
	 their caller's return pc into instructionPointer.  In this uncommon case restore
	 it, since a send's call pushes the instructionPointer (after the arguments)."
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorCannotReturn)
		to: aContext
		numArgs: 1