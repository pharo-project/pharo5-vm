inline cacheing
inlineCacheTagAt: followingAddress
	^objectMemory longAt: (self pcRelativeAddressAt: followingAddress - 8)