debug support
mnuCompilationBreakpointFor: selectorOop
	<api>
	suppressHeartbeatFlag := true.
	self
		cCode: [self warning: 'compilation MNU break (heartbeat suppressed)']
		inSmalltalk: [self halt: 'Compilation for MNU of ', breakSelector]