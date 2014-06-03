initialization
loadInitialContext
	<inline: false>
	| activeProc activeContext |
	self cCode: [] inSmalltalk: [self initExtensions].
	objectMemory runLeakCheckerForFullGC: true.
	activeProc := self activeProcess.
	activeContext := objectMemory fetchPointer: SuspendedContextIndex ofObject: activeProc.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext