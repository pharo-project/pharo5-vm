inline cacheing
literalBeforeInlineCacheTagAt: callSiteReturnAddress
	"Answer a literal loaded before the inline cache tag load for the return address of a send."
	^self literalBeforeFollowingAddress: callSiteReturnAddress - 12 "5 for the call plus 7 for the selectorIndex/classIndex load"