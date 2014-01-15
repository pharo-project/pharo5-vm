object memory support
markAndTraceInterpreterOops: fullGCFlag
	"Mark and trace all oops in the interpreter's state."
	"Assume: All traced variables contain valid oops."
	| oop |
	<var: #vmThread type: #'CogVMThread *'>
	"Must mark stack pages first to initialize the per-page trace
	 flags for full garbage collect before any subsequent tracing."
	self markAndTraceStackPages: fullGCFlag.
	self markAndTraceTraceLog.
	self markAndTracePrimTraceLog.
	objectMemory markAndTrace: objectMemory specialObjectsOop. "also covers nilObj, trueObj, falseObj, and compact classes"
	(objectMemory isIntegerObject: messageSelector) ifFalse:
		[objectMemory markAndTrace: messageSelector].
	(objectMemory isIntegerObject: newMethod) ifFalse:
		[objectMemory markAndTrace: newMethod].
	objectMemory markAndTrace: lkupClass.
	self traceProfileState.
	tempOop = 0 ifFalse: [objectMemory markAndTrace: tempOop].

	1 to: objectMemory remapBufferCount do:
		[:i|
		oop := objectMemory remapBuffer at: i.
		(objectMemory isIntegerObject: oop) ifFalse:
			[objectMemory markAndTrace: oop]].

	"Callback support - trace suspended callback list - will be made per-thread soon"
	1 to: jmpDepth do:
		[:i|
		oop := suspendedCallbacks at: i.
		(objectMemory isIntegerObject: oop) ifFalse:
			[objectMemory markAndTrace: oop].
		oop := suspendedMethods at: i.
		(objectMemory isIntegerObject: oop) ifFalse:
			[objectMemory markAndTrace: oop]].

	"Per-thread state; trace each thread's own newMethod and stack of awol processes."
	1 to: cogThreadManager getNumThreads do:
		[:i| | vmThread |
		vmThread := cogThreadManager vmThreadAt: i.
		vmThread state notNil ifTrue:
			[vmThread newMethodOrNull notNil ifTrue:
				[objectMemory markAndTrace: vmThread newMethodOrNull].
			 0 to: vmThread awolProcIndex - 1 do:
				[:j|
				objectMemory markAndTrace: (vmThread awolProcesses at: j)]]]