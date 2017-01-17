inline cacheing
literalBeforeInlineCacheTagAt: callSiteReturnAddress
	"Answer a literal loaded before the inline cache tag load for the return address of a send."
	^self literalBeforeFollowingAddress: callSiteReturnAddress - 10