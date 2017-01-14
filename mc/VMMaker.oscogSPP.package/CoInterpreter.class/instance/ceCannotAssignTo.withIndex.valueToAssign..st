trampolines
ceCannotAssignTo: immutableObject withIndex: index valueToAssign: valueToAssign
	"index is unboxed."
	<api>
	<option: #IMMUTABILITY>
	instructionPointer := self popStack.
	self push: immutableObject.
	self push: valueToAssign.
	self push: (objectMemory integerObjectOf: index).
	self push: instructionPointer.
	^ self
		ceSendAbort: (objectMemory splObj: SelectorAttemptToAssign)
		to: immutableObject
		numArgs: 2