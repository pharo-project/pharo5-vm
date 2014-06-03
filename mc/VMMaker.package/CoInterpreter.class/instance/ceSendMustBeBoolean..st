trampolines
ceSendMustBeBoolean: anObject
	<api>
	instructionPointer := self popStack.
	self push: anObject.
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorMustBeBoolean)
		to: anObject
		numArgs: 0