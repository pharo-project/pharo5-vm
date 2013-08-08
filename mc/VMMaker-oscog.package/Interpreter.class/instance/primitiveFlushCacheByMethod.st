system control primitives
primitiveFlushCacheByMethod
	"The receiver is a compiledMethod.  Clear all entries in the method lookup cache that refer to this method, presumably because it has been redefined, overridden or removed."
	| probe oldMethod |
	oldMethod := self stackTop.
	probe := 0.
	1 to: MethodCacheEntries do:
		[:i | (methodCache at: probe + MethodCacheMethod) = oldMethod ifTrue:
			[methodCache at: probe + MethodCacheSelector put: 0].
		probe := probe + MethodCacheEntrySize].
	self compilerFlushCacheHook: oldMethod.		"Flush the dynamic compiler's inline caches."