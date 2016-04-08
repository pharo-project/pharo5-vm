initialization
initializeCaches
	"Eliminate the AtCache"
	super initializeCaches.
	AtCacheTotalSize := AtCacheSize := AtCacheMask := AtCacheFixedFields := AtCacheFmt := AtCacheOop := #undefined