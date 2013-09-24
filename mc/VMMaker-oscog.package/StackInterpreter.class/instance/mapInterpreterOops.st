object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	 during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	self mapStackPages.
	self mapMachineCode.
	self mapTraceLogs.
	self mapVMRegisters.
	self mapProfileState.
	self remapCallbackState.
	(tempOop ~= 0
	 and: [objectMemory shouldRemapOop: tempOop]) ifTrue:
		[tempOop := objectMemory remapObj: tempOop]