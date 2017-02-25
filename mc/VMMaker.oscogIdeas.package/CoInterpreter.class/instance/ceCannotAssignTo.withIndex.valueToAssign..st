trampolines
ceCannotAssignTo: immutableObject withIndex: index valueToAssign: valueToAssign
	"index is unboxed and 0-based. The call-back expects 1-based value (to perform the operation with instVarAt:put:"
	<api>
	<option: #IMMUTABILITY>
	instructionPointer := self popStack.
	self push: immutableObject.
	self push: valueToAssign.
	self push: (objectMemory integerObjectOf: index + 1).
	self push: instructionPointer.
	^ self
		ceSendAbort: (objectMemory splObj: SelectorAttemptToAssign)
		to: immutableObject
		numArgs: 2