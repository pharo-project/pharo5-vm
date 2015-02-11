initialization
loadInitialContext
	<inline: false>
	| activeProc activeContext |
	self cCode: [] inSmalltalk: [self initExtensions].
	objectMemory runLeakCheckerFor: GCModeFull.
	activeProc := self activeProcess.
	activeContext := objectMemory fetchPointer: SuspendedContextIndex ofObject: activeProc.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext