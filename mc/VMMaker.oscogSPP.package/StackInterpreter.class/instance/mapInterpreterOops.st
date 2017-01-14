object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	 during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	<inline: false>
	self mapStackPages.
	self mapMachineCode: self getGCMode.
	self mapTraceLogs.
	self mapVMRegisters.
	self mapProfileState.
	self remapCallbackState.
	(tempOop ~= 0
	 and: [objectMemory shouldRemapOop: tempOop]) ifTrue:
		[tempOop := objectMemory remapObj: tempOop].
	(tempOop2 ~= 0
	 and: [objectMemory shouldRemapOop: tempOop2]) ifTrue:
		[tempOop2 := objectMemory remapObj: tempOop2].
	(tempOop3 ~= 0
	 and: [objectMemory shouldRemapOop: tempOop3]) ifTrue:
		[tempOop3 := objectMemory remapObj: tempOop3]