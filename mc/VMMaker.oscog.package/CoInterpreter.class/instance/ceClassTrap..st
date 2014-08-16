trampolines
ceClassTrap: anObject
	<api>
	<option: #SistaVM>
	| context |
	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	"If there is a class trap, the object is supposed to remain on
	 the stack, but the cogit always removes it.  So restore it here."
	self push: anObject.
	self push: context.
	self push: anObject.
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorClassTrap)
		to: anObject
		numArgs: 1