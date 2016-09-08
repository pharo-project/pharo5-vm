debug support
compilationBreakpointFor: selectorOop
	<api>
	suppressHeartbeatFlag := true.
	self
		cCode: [self warning: 'compilation send break (heartbeat suppressed)']
		inSmalltalk: [self halt: 'Compilation of ', breakSelector]