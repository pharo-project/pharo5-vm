object memory support
mapInterpreterOops
	"Map all oops in the interpreter's state to their new values 
	 during garbage collection or a become: operation."
	"Assume: All traced variables contain valid oops."
	<var: #vmThread type: #'CogVMThread *'>
	super mapInterpreterOops.

	"Per-thread state; trace each thread's own newMethod and stack of awol processes."
	1 to: cogThreadManager getNumThreads do:
		[:i| | vmThread |
		vmThread := cogThreadManager vmThreadAt: i.
		vmThread state ifNotNil:
			[(vmThread newMethodOrNull notNil
			 and: [objectMemory shouldRemapOop: vmThread newMethodOrNull]) ifTrue:
				[vmThread newMethodOrNull: (objectMemory remapObj: vmThread newMethodOrNull)].
			 0 to: vmThread awolProcIndex - 1 do:
				[:j|
				(objectMemory shouldRemapOop: (vmThread awolProcesses at: j)) ifTrue:
					[vmThread awolProcesses at: j put: (objectMemory remap: (vmThread awolProcesses at: j))]]]]