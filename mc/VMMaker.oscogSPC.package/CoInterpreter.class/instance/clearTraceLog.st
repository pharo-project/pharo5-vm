debug support
clearTraceLog
	<api>
	traceLogIndex := 0.
	0 to: TraceBufferSize - 1 do:
		[:i|
		traceLog at: i put: 0]