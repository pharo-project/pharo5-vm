inline cacheing
inlineCacheTagAt: address
	^objectMemory longAt: (self pcRelativeAddressAt: address - 8)