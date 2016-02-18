sista support
maybeMarkCounters: theCounters
	"In SIsta Spur counters are held on the heap in pinned objects which must be marked
	 to avoid them being garbage collected.  This is the hook through which that happens.
	 By default, do nothing."
	<var: #theCounters type: #usqInt>
	<inline: true>