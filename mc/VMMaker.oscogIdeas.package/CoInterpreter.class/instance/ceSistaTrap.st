trampolines
ceSistaTrap
	"When we arrive here, the value that trapped is pushed on stack"
	<api>
	<option: #SistaVM>
	| context |
	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self push: context.
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorSistaTrap)
		to: context
		numArgs: 0