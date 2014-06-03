object memory support
checkLogIntegrity
	"Check the log for leaks.  The trace log is a circular buffer of pairs of entries.
	 If there is an entry at traceLogIndex - 3 \\ TraceBufferSize it has entries.  If
	 there is something at traceLogIndex it has wrapped."
	| limit ok |
	limit := self safe: traceLogIndex - 3 mod: TraceBufferSize.
	(traceLog at: limit) = 0 ifTrue: [^true].
	(traceLog at: traceLogIndex) ~= 0 ifTrue:
		[limit := TraceBufferSize - 3].
	ok := true.
	0 to: limit by: 3 do:
		[:i| | oop |
		oop := traceLog at: i.
		(objectMemory isImmediate: oop) ifFalse:
			[(objectMemory checkOopIntegrity: oop named: 'traceLog' index: i) ifFalse:
				[ok := false]].
		oop := traceLog at: i + 1.
		(objectMemory isImmediate: oop) ifFalse:
			[(objectMemory checkOopIntegrity: oop named: 'traceLog' index: i + 1) ifFalse:
				[ok := false]]].
	^ok