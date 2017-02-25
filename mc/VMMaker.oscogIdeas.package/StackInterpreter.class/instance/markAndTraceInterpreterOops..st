object memory support
markAndTraceInterpreterOops: fullGCFlag
	"Mark and trace all oops in the interpreter's state."
	"Assume: All traced variables contain valid oops.
	 N.B. Don't trace messageSelector and lkupClass; these are ephemeral, live
	 only during message lookup and because createActualMessageTo will not
	 cause a GC these cannot change during message lookup."
	| oop |
	"Must mark stack pages first to initialize the per-page trace
	 flags for full garbage collect before any subsequent tracing."
	self markAndTraceStackPages: fullGCFlag.
	self markAndTraceTraceLog.
	self markAndTracePrimTraceLog.
	objectMemory markAndTrace: objectMemory specialObjectsOop. "also covers nilObj, trueObj, falseObj, and compact classes"
	(objectMemory isImmediate: newMethod) ifFalse:
		[objectMemory markAndTrace: newMethod].
	self traceProfileState.
	tempOop = 0 ifFalse: [objectMemory markAndTrace: tempOop].
	tempOop2 = 0 ifFalse: [objectMemory markAndTrace: tempOop2].
	tempOop3 = 0 ifFalse: [objectMemory markAndTrace: tempOop3].

	1 to: objectMemory remapBufferCount do: [:i | 
			oop := objectMemory remapBuffer at: i.
			(objectMemory isIntegerObject: oop) ifFalse: [objectMemory markAndTrace: oop]].

	"Callback support - trace suspended callback list"
	1 to: jmpDepth do:[:i|
		oop := suspendedCallbacks at: i.
		(objectMemory isIntegerObject: oop) ifFalse:[objectMemory markAndTrace: oop].
		oop := suspendedMethods at: i.
		(objectMemory isIntegerObject: oop) ifFalse:[objectMemory markAndTrace: oop].
	]