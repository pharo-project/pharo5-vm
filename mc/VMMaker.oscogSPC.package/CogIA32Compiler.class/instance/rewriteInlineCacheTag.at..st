inline cacheing
rewriteInlineCacheTag: cacheTag at: callSiteReturnAddress
	"Rewrite an inline cache with a new tag.  This variant is used
	 by the garbage collector."
	objectMemory
		byteAt: callSiteReturnAddress - 6 put: (cacheTag >> 24 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 7 put: (cacheTag >> 16 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 8 put: (cacheTag >>   8 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 9 put: (cacheTag            bitAnd: 16rFF)