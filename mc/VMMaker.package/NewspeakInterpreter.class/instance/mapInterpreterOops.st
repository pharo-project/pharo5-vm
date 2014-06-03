object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	stackPointer := stackPointer - activeContext. "*rel to active"
	activeContext := self remap: activeContext.
	stackPointer := stackPointer + activeContext. "*rel to active"
	theHomeContext := self remap: theHomeContext.
	instructionPointer := instructionPointer - method. "*rel to method"
	method := self remap: method.
	instructionPointer := instructionPointer + method. "*rel to method"
	receiver := self remap: receiver.
	(self isIntegerObject: messageSelector) ifFalse:
		[messageSelector := self remap: messageSelector].
	(self isIntegerObject: newMethod) ifFalse:
		[newMethod := self remap: newMethod].
	lkupClass := self remap: lkupClass.
	self mapTraceLogs