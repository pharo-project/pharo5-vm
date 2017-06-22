method lookup cache
flushMethodCacheForMethod: oldMethod
	"Flush the method caches of references to oldMethod."
	| probe |
	probe := 0.
	1 to: MethodCacheEntries do:
		[:i |
		(methodCache at: probe + MethodCacheMethod) = oldMethod ifTrue:
			[methodCache at: probe + MethodCacheSelector put: 0].
		probe := probe + MethodCacheEntrySize].
	self flushExternalPrimitiveOf: oldMethod.
	self flushAtCache