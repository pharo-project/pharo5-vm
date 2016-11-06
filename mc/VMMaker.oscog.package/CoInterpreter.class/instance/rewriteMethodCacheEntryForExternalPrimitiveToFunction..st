method lookup cache
rewriteMethodCacheEntryForExternalPrimitiveToFunction: localPrimAddress
	"Rewrite an existing entry in the method cache with a new primitive function address.
	 Used by primitiveExternalCall to make direct calls to found external prims, or quickly
	 fail not found external prims.
	 Override to do the same to the machine code call.  If methodObj has a cogged dual
	 rewrite the primitive call in it to call localPrimAddress. Used to update calls through
	 primitiveExternalCall to directly call the target function or to revert to calling
	 primitiveExternalCall after a flush."
	<var: #localPrimAddress declareC: 'void (*localPrimAddress)(void)'>
	<inline: false>
	(self methodHasCogMethod: newMethod) ifTrue:
		[cogit
			rewritePrimInvocationIn: (self cogMethodOf: newMethod)
			to: (localPrimAddress = 0
				ifTrue: [self cCoerceSimple: #primitiveFail to: #'void (*)(void)']
				ifFalse: [localPrimAddress])].
	(methodCache at: lastMethodCacheProbeWrite + MethodCacheMethod) = newMethod ifTrue:
		[methodCache
			at: lastMethodCacheProbeWrite + MethodCachePrimFunction
			put: (self cCoerce: localPrimAddress to: #'sqIntptr_t')]