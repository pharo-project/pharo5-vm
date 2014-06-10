debug support
mapTraceLogs
	"The prim and send trace logs are circular buffers of selectors. If there is
	 an entry at primTraceLogIndex - 1 \\ PrimTraceBufferSize it has entries.
	 If there is something at primTraceLogIndex it has wrapped."
	<inline: false>
	| limit |
	limit := self safe: primTraceLogIndex - 1 mod: TraceLogSize.
	(primTraceLog at: limit) = 0 ifTrue: [^self].
	(primTraceLog at: primTraceLogIndex) ~= 0 ifTrue:
		[limit := TraceLogSize - 1].
	0 to: limit do:
		[:i| | selector |
		selector := primTraceLog at: i.
		(self isIntegerObject: selector) ifFalse:
			[primTraceLog at: i put: (self remap: selector)]].
	limit := self safe: sendTraceLogIndex - 1 mod: TraceLogSize.
	(sendTraceLog at: limit) = 0 ifTrue: [^nil].
	(sendTraceLog at: sendTraceLogIndex) ~= 0 ifTrue:
		[limit := TraceLogSize - 1].
	0 to: limit do:
		[:i| | selector |
		selector := sendTraceLog at: i.
		(self isIntegerObject: selector) ifFalse:
			[sendTraceLog at: i put: (self remap: selector)]]