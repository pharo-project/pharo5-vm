inline cacheing
inlineCacheTagAt: callSiteReturnAddress
	<inline: true>
	^objectMemory longAt: (self pcRelativeAddressAt: (callSiteReturnAddress - 8) asUnsignedInteger)