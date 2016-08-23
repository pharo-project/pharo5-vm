inline cacheing
rewriteInlineCacheTag: cacheTag at: callSiteReturnAddress
	"Rewrite an inline cache with a new tag.  This variant is used
	 by the garbage collector."
	self insert32BitOperand: cacheTag into4InstructionsPreceding: callSiteReturnAddress -4