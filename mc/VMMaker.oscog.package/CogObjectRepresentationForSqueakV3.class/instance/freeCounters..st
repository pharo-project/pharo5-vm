sista support
freeCounters: theCounters
	<var: #theCounters type: #usqInt>
	theCounters ~= 0 ifTrue:
		[self free: theCounters - (self sizeof: #sqInt)]