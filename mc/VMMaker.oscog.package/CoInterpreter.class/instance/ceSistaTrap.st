trampolines
ceSistaTrap
	<api>
	<option: #SistaVM>
	| context obj |
	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	"If there is a trap, the object is supposed to remain on
	 the stack, but the cogit always removes it.  So restore it here."
	obj := self stackTop.
	self push: context.
	self push: obj.
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorSistaTrap)
		to: context
		numArgs: 1