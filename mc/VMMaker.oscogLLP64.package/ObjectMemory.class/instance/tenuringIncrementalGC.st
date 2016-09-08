garbage collection
tenuringIncrementalGC
	"Do an incremental GC that tenures all surviving young objects to old space."
	<api>
	forceTenureFlag := true.
	self incrementalGC