return bytecodes
externalAboutToReturn: resultOop through: aContext
	| ourContext |
	<inline: true>
	ourContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self push: ourContext.
	self push: resultOop.
	self push: aContext.
	"The ceNonLocalReturnTrampoline pops its caller's return pc into instructionPointer.
	 In this uncommon case restore it, since a send's call pushes the instructionPointer (after the arguments)."
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorAboutToReturn)
		to: ourContext
		numArgs: 2