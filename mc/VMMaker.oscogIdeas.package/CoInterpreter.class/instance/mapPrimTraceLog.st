debug support
mapPrimTraceLog
	"The prim trace log is a circular buffer of selectors. If there is
	 an entry at primTraceLogIndex - 1 \\ PrimTraceBufferSize it has entries.
	 If there is something at primTraceLogIndex it has wrapped."
	<inline: false>
	(primTraceLog at: (self safe: primTraceLogIndex - 1 mod: PrimTraceLogSize)) = 0 ifTrue:
		[^self].
	(primTraceLog at: primTraceLogIndex) ~= 0 ifTrue:
		[primTraceLogIndex to: PrimTraceLogSize - 1 do:
			[:i| | selector |
			 selector := primTraceLog at: i.
			 (selector ~= 0
			  and: [objectMemory shouldRemapOop: selector]) ifTrue:
				[primTraceLog at: i put: (objectMemory remapObj: selector)]]].
	0 to: primTraceLogIndex - 1 do:
		[:i| | selector |
		 selector := primTraceLog at: i.
		 (selector ~= 0
		  and: [objectMemory shouldRemapOop: selector]) ifTrue:
			[primTraceLog at: i put: (objectMemory remapObj: selector)]]