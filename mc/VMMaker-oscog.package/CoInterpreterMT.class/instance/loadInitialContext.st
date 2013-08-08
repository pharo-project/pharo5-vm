initialization
loadInitialContext
	| activeProc |
	super loadInitialContext.
	activeProc := self activeProcess.
	self assert: (self ownerIndexOfProcess: activeProc) = 0.
	activeProcessAffined := (self ownerIndexOfProcess: activeProc) ~= 0