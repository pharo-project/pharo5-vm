initialization
initializeCaches

	| atCacheEntrySize |
	MethodCacheEntries := 512. 
	MethodCacheSelector := 1.
	MethodCacheClass := 2.
	MethodCacheMethod := 3.
	MethodCachePrim := 4.
	MethodCachePrimFunction := 5.
	MethodCacheEntrySize := 8.  "Must be power of two for masking scheme."
	MethodCacheMask := (MethodCacheEntries - 1) * MethodCacheEntrySize.
	MethodCacheSize := MethodCacheEntries * MethodCacheEntrySize.
	CacheProbeMax := 3.

	AtCacheEntries := 8.  "Must be a power of two"
	AtCacheOop := 1.
	AtCacheSize := 2.
	AtCacheFmt := 3.
	AtCacheFixedFields := 4.
	atCacheEntrySize := 4.  "Must be power of two for masking scheme."
	AtCacheMask := (AtCacheEntries-1) * atCacheEntrySize.
	AtPutBase := AtCacheEntries * atCacheEntrySize.
	AtCacheTotalSize := AtCacheEntries * atCacheEntrySize * 2.
