debug support
recordContextSwitchFrom: aProcess in: sourceCode
	cogit recordEventTrace ifTrue:
		[self recordTrace: TraceContextSwitch thing: aProcess source: sourceCode]