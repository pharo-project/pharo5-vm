inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
	
	^self subclassResponsibility