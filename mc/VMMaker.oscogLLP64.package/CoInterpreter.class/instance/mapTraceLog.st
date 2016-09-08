debug support
mapTraceLog
	"The trace log is a circular buffer of pairs of entries. If there is
	 an entry at traceLogIndex - 3 \\ TraceBufferSize it has entries.
	 If there is something at traceLogIndex it has wrapped."
	<inline: false>
	| limit |
	limit := self safe: traceLogIndex - 3 mod: TraceBufferSize.
	(traceLog at: limit) = 0 ifTrue: [^self].
	(traceLog at: traceLogIndex) ~= 0 ifTrue:
		[limit := TraceBufferSize - 3].
	0 to: limit by: 3 do:
		[:i| | intOrClass selectorOrMethod |
		intOrClass := traceLog at: i.
		(objectMemory shouldRemapOop: intOrClass) ifTrue:
			[traceLog at: i put: (objectMemory remapObj: intOrClass)].
		selectorOrMethod := traceLog at: i + 1.
		(objectMemory shouldRemapOop: selectorOrMethod) ifTrue:
			[traceLog at: i + 1 put: (objectMemory remapObj: selectorOrMethod)]]