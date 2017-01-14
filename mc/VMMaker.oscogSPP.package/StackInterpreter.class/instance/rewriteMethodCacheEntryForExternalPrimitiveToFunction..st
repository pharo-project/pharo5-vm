method lookup cache
rewriteMethodCacheEntryForExternalPrimitiveToFunction: localPrimAddress
	"Rewrite an existing entry in the method cache with a new primitive function address.
	 Used by primitiveExternalCall to make direct calls to found external prims, or quickly
	 fail not found external prims."
	<inline: false>
	<var: #localPrimAddress declareC: 'void (*localPrimAddress)(void)'>
	(methodCache at: lastMethodCacheProbeWrite + MethodCacheMethod) = newMethod ifTrue:
		[methodCache
			at: lastMethodCacheProbeWrite + MethodCachePrimFunction
			put: (self cCoerce: localPrimAddress to: #'sqIntptr_t')]