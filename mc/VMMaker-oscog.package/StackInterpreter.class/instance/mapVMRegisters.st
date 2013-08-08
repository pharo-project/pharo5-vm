object memory support
mapVMRegisters
	"Map the oops in the interpreter's vm ``registers'' to their new values 
	during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	instructionPointer := instructionPointer - method. "*rel to method"
	method := (objectMemory remap: method).
	instructionPointer := instructionPointer + method. "*rel to method"
	(objectMemory isIntegerObject: messageSelector) ifFalse:
		[messageSelector := objectMemory remap: messageSelector].
	(objectMemory isIntegerObject: newMethod) ifFalse:
		[newMethod := objectMemory remap: newMethod].
	lkupClass := objectMemory remap: lkupClass