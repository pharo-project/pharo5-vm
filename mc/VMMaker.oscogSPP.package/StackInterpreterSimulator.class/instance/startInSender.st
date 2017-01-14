simulation only
startInSender
	"Change the active process's suspendedContext to its sender, which short-cuts the
	 initialization of the system.  This can be a short-cut to running code, e.g. when doing
		Smalltalk saveAs.
		Compiler recompileAll"
	
	| activeContext activeProc senderContext |
	activeProc := self activeProcess.
	activeContext := objectMemory fetchPointer: SuspendedContextIndex ofObject: activeProc.
	senderContext := objectMemory fetchPointer: SenderIndex ofObject: activeContext.
	objectMemory storePointer: SuspendedContextIndex ofObject: activeProc withValue: senderContext.
	"Now push a dummy return value."
	objectMemory
		storePointer: (self fetchStackPointerOf: senderContext) + CtxtTempFrameStart
		ofObject: senderContext
		withValue: objectMemory nilObject.
	self storeInteger: StackPointerIndex
		ofObject: senderContext
		withValue: (self fetchStackPointerOf: senderContext) + 1