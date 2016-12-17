class initialization
initialize
	"Pig compact can be repeated to compact better.  Experience shows that 3 times
	 compacts very well, desirable for snapshots.  But this is overkill for normal GCs."
	CompactionPassesForGC := 2.
	CompactionPassesForSnapshot := 3