method lookup cache
flushMethodCache
	"Flush the method cache. The method cache is flushed on every programming change and garbage collect."

	super flushMethodCache.
	cogit unlinkAllSends