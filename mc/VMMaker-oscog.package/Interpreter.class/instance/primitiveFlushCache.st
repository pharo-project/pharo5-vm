system control primitives
primitiveFlushCache
	"Clear the method lookup cache. This must be done after every programming change."

	self flushMethodCache.
	self compilerFlushCacheHook: nil.		"Flush the dynamic compiler's inline caches."
