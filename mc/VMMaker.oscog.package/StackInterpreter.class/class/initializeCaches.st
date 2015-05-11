initialization
initializeCaches

	| atCacheEntrySize |
	MethodCacheEntries := 1024. 
	MethodCacheSelector := 1.
	MethodCacheClass := 2.
	MethodCacheMethod := 3.
	MethodCachePrimFunction := 4.
	MethodCacheEntrySize := 4.  "Must be power of two for masking scheme."
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

	"LookupRuleOuter is [0, 255], with the value being the lexical depth. Note that an
	 outer send to lexical depth 0 is equivalent to a self send. Implicit receiver and
	 outer sends are encoded as adjacent values to allow a quick range check to
	 determine whether the absent receiver might differ from the method receiver.
	 Note also Smalltalk super sends use ordinary send lookup rules."
	LookupRuleSelf := 0.
	LookupRuleImplicit := 256.
	LookupRuleDynamicSuper := 257.
	LookupRuleOrdinary := 258.
	LookupRuleMNU := 259.
