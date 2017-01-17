initialization
initializeCaches

	| atCacheEntries atCacheEntrySize |
	NewspeakVM
		ifTrue: [MethodCacheEntries := 512]
		ifFalse: [MethodCacheEntries := 1024].
	MethodCacheSelector := 1.
	MethodCacheClass := 2.
	MethodCacheMethod := 3.
	MethodCachePrimFunction := 4.
	MethodCacheEntrySize := 4.  "Must be power of two for masking scheme."
	MethodCacheMask := (MethodCacheEntries - 1) * MethodCacheEntrySize.
	MethodCacheSize := MethodCacheEntries * MethodCacheEntrySize.
	CacheProbeMax := 3.

	NSMethodCacheEntries := 512.
	NSMethodCacheSelector := 1.
	NSMethodCacheClassTag := 2.
	NSMethodCacheCallingMethod := 3.
	NSMethodCacheDepthOrLookupRule := 4.
	NSMethodCacheTargetMethod := 5.
	NSMethodCachePrimFunction := 6.
	NSMethodCacheActualReceiver := 7.
	NSMethodCacheEntrySize := 8.	"Must be power of two for masking scheme."
	NSMethodCacheMask := NSMethodCacheEntries - 1 * NSMethodCacheEntrySize.
	NSMethodCacheSize := NSMethodCacheEntries * NSMethodCacheEntrySize.

	AtCacheOop := 1.
	AtCacheSize := 2.
	AtCacheFmt := 3.
	AtCacheFixedFields := 4.
	atCacheEntries := 8.
	atCacheEntrySize := 4.  "Must be power of two for masking scheme."
	AtCacheMask := (atCacheEntries-1) * atCacheEntrySize.
	AtPutBase := atCacheEntries * atCacheEntrySize.
	AtCacheTotalSize := atCacheEntries * atCacheEntrySize * 2.

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
