method lookup cache
rewriteMethodCacheEntryForExternalPrimitiveToFunction: localPrimAddress
	super rewriteMethodCacheEntryForExternalPrimitiveToFunction:
				(self mapFunctionToAddress: (localPrimAddress = 0
												ifTrue: [#primitiveFail]
												ifFalse: [localPrimAddress])).
	"Hack; the super call will rewrite the entry to the address of the function.
	 So (when simulating) undo the damage and put back the functionPointer"
	(methodCache at: lastMethodCacheProbeWrite + MethodCacheMethod) = newMethod ifTrue:
		[methodCache
			at: lastMethodCacheProbeWrite + MethodCachePrimFunction
			put: (self cCoerce: localPrimAddress to: #'sqIntptr_t')]