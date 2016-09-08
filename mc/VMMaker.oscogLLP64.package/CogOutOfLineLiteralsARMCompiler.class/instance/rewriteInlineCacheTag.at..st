inline cacheing
rewriteInlineCacheTag: cacheTag at: callSiteReturnAddress
	"Rewrite an inline cache with a new tag.  This variant is used
	 by the garbage collector."
	<inline: true>
	objectMemory longAt: (self pcRelativeAddressAt: callSiteReturnAddress - 8) put: cacheTag