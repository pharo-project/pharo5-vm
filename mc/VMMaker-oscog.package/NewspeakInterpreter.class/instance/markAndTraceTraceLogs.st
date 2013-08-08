debug support
markAndTraceTraceLogs
	"The prim and send trace logs are circular buffers of selectors. If there is
	 an entry at primTraceLogIndex - 1 \\ PrimTraceBufferSize it has entries.
	 If there is something at primTraceLogIndex it has wrapped."
	<inline: false>
	| limit |
	RecordPrimTrace ifTrue:
		[limit := self safe: primTraceLogIndex - 1 mod: TraceLogSize.
		(primTraceLog at: limit) ~= 0 ifTrue:
			[(primTraceLog at: primTraceLogIndex) ~= 0 ifTrue:
				[limit := TraceLogSize - 1].
			0 to: limit do:
				[:i| | selector |
				selector := primTraceLog at: i.
				(self isIntegerObject: selector) ifFalse:
					[self markAndTrace: selector]]]].
	RecordSendTrace ifTrue:
		[limit := self safe: sendTraceLogIndex - 1 mod: TraceLogSize.
		(sendTraceLog at: limit) ~= 0 ifTrue:
			[(sendTraceLog at: sendTraceLogIndex) ~= 0 ifTrue:
				[limit := TraceLogSize - 1].
			0 to: limit do:
				[:i| | selector |
				selector := sendTraceLog at: i.
				(self isIntegerObject: selector) ifFalse:
					[self markAndTrace: selector]]]]