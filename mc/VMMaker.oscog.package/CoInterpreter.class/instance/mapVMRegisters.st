object memory support
mapVMRegisters
	"Map the oops in the interpreter's vm ``registers'' to their new values 
	 during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops.
	 N.B. Don't trace messageSelector and lkupClass; these are ephemeral, live
	 only during message lookup and because createActualMessageTo will not
	 cause a GC these cannot change during message lookup."
	| mapInstructionPointer |
	(objectMemory shouldRemapObj: method) ifTrue:
		["i.e. interpreter instructionPointer in method as opposed to machine code?"
		(mapInstructionPointer := instructionPointer > method) ifTrue:
			[instructionPointer := instructionPointer - method]. "*rel to method"
		method := objectMemory remapObj: method.
		mapInstructionPointer ifTrue:
			[instructionPointer := instructionPointer + method]]. "*rel to method"
	(objectMemory shouldRemapOop: newMethod) ifTrue: "maybe oop due to object-as-method"
		[newMethod := objectMemory remapObj: newMethod]