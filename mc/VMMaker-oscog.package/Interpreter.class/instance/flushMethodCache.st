method lookup cache
flushMethodCache
	"Flush the method cache. The method cache is flushed on every programming change and garbage collect."

	1 to: MethodCacheSize do: [ :i | methodCache at: i put: 0 ].
	1 to: AtCacheTotalSize do: [ :i | atCache at: i put: 0 ].
