inline cacheing
rewriteInlineCacheTag: cacheTag at: callSiteReturnAddress
	"Rewrite an inline cache with a new tag.  This variant is used
	 by the garbage collector."
	self unalignedLong32At: callSiteReturnAddress - 9 put: cacheTag