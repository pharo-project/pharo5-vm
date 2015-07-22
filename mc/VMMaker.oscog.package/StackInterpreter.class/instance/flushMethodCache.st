method lookup cache
flushMethodCache
	"Flush the method cache. The method cache is flushed on every programming change and garbage collect."

	1 to: MethodCacheSize do: [ :i | methodCache at: i put: 0 ].
	NewspeakVM ifTrue:
		[1 to: NSMethodCacheSize do: [ :i | nsMethodCache at: i put: 0 ]].
	lastMethodCacheProbeWrite := 0. "this for primitiveExternalMethod"
	self flushAtCache