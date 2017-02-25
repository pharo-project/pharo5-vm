sista support
allocateCounters: nCounters
	"Malloc the counter space.  Fill the first slot with the number of counters for resetCountersIn:"
	| theCounters |
	<var: #theCounters type: #usqInt>
	theCounters := self malloc: nCounters + 1 * (self sizeof: #sqInt).
	theCounters = 0 ifTrue:
		[^theCounters].
	self longAt: theCounters put: nCounters.
	^theCounters + (self sizeof: #sqInt)