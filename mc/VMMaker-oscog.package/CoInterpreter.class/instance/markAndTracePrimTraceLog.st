debug support
markAndTracePrimTraceLog
	"The prim trace log is a circular buffer of selectors. If there is
	 an entry at primTraceLogIndex - 1 \\ PrimTraceBufferSize it has entries.
	 If there is something at primTraceLogIndex it has wrapped."
	<inline: false>
	| limit |
	limit := self safe: primTraceLogIndex - 1 mod: PrimTraceLogSize.
	(primTraceLog at: limit) = 0 ifTrue: [^nil].
	(primTraceLog at: primTraceLogIndex) ~= 0 ifTrue:
		[limit := PrimTraceLogSize - 1].
	0 to: limit do:
		[:i| | selector |
		selector := primTraceLog at: i.
		(objectMemory isIntegerObject: selector) ifFalse:
			[objectMemory markAndTrace: selector]]