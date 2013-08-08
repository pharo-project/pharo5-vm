object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	| oop |
	objectMemory nilObject: (objectMemory remap: objectMemory nilObject).
	objectMemory falseObject: (objectMemory remap: objectMemory falseObject).
	objectMemory trueObject: (objectMemory remap: objectMemory trueObject).
	objectMemory specialObjectsOop: (objectMemory remap: objectMemory specialObjectsOop).
	self mapStackPages.
	self mapMachineCode.
	self mapTraceLogs.
	self mapVMRegisters.
	self mapProfileState.
	tempOop = 0 ifFalse: [tempOop := objectMemory remap: tempOop].
	1 to: objectMemory remapBufferCount do: [:i | 
			oop := objectMemory remapBuffer at: i.
			(objectMemory isIntegerObject: oop)
				ifFalse: [objectMemory remapBuffer at: i put: (objectMemory remap: oop)]].

	"Callback support - trace suspended callback list"
	1 to: jmpDepth do:[:i|
		oop := suspendedCallbacks at: i.
		(objectMemory isIntegerObject: oop) 
			ifFalse:[suspendedCallbacks at: i put: (objectMemory remap: oop)].
		oop := suspendedMethods at: i.
		(objectMemory isIntegerObject: oop) 
			ifFalse:[suspendedMethods at: i put: (objectMemory remap: oop)].
	].
