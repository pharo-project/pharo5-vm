object memory support
mapVMRegisters
	"Map the oops in the interpreter's vm ``registers'' to their new values 
	 during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	| mapInstructionPointer |
	"i.e. interpreter instructionPointer in method as opposed to machine code?"
	(mapInstructionPointer := instructionPointer > method) ifTrue:
		[instructionPointer := instructionPointer - method]. "*rel to method"
	method := (objectMemory remap: method).
	mapInstructionPointer ifTrue:
		[instructionPointer := instructionPointer + method]. "*rel to method"
	messageSelector := objectMemory remap: messageSelector.
	(objectMemory isIntegerObject: newMethod) ifFalse:
		[newMethod := objectMemory remap: newMethod].
	lkupClass := objectMemory remap: lkupClass