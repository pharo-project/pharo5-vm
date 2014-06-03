debug support
dumpSendTraceLog
	"The send trace log is a circular buffer of entries. If there is
	 an entry at sendTraceLogIndex \\ PrimTraceLogSize it has entries.
	 If there is something at sendTraceLogIndex it has wrapped."

	<api>
	<inline: false>
	(sendTraceLog at: (self safe: sendTraceLogIndex - 1 mod: TraceLogSize)) = 0 ifTrue: [^self].
	(sendTraceLog at: sendTraceLogIndex) ~= 0 ifTrue:
		[sendTraceLogIndex to: TraceLogSize - 1 do:
			[:i | self safePrintStringOf: (sendTraceLog at: i); cr]].
	0 to: sendTraceLogIndex - 1 do:
		[:i | self safePrintStringOf: (sendTraceLog at: i); cr]