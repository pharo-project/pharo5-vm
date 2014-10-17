compile abstract instructions
maybeFreeCounters
	<inline: true>
	counters ~= 0 ifTrue:
		[objectMemory freeCounters: counters]