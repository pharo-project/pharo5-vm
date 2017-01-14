inline cacheing
inlineCacheTagAt: callSiteReturnAddress
	"Answer the inline cache tag for the return address of a send."
	^self literalBeforeFollowingAddress: callSiteReturnAddress - 5