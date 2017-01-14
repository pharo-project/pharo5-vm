sista support
numCountersFor: theCounters
	<var: #theCounters type: #usqInt>
	^objectMemory longAt: theCounters - (self sizeof: #sqInt)