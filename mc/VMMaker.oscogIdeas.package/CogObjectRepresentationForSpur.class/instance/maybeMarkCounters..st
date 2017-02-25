sista support
maybeMarkCounters: theCounters
	"In SIsta Spur counters are held on the heap in pinned objects which must be marked
	 to avoid them being garbage collected.  This is the hook through which that happens."
	<var: #theCounters type: #usqInt>
	<option: #SistaCogit>
	<inline: true>
	theCounters ~= 0 ifTrue:
		[objectMemory markAndTrace: theCounters - objectMemory baseHeaderSize]