debug support
fastLogSend: aSelector
	"Fast tracing of sends.  sendTraceLogIndex is a byte variable.
	 sendTraceLog has 256 entries.  In C the + 1 below is hence implicitly modulo 256."
	<inline: true>
	RecordSendTrace ifTrue:
		[sendTraceLog at: sendTraceLogIndex put: aSelector.
		 self sendTraceLogIndex: sendTraceLogIndex + 1]