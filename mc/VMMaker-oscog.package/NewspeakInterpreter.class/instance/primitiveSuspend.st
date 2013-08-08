process primitives
primitiveSuspend

	| activeProc |
	activeProc := self activeProcess.
	self success: self stackTop = activeProc.
	self successful ifTrue:
		[self pop: 1 thenPush: nilObj.
		self transferTo: self wakeHighestPriority]