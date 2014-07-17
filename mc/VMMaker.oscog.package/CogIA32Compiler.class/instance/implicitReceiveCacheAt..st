inline cacheing
implicitReceiveCacheAt: callSiteReturnAddress
	"Answer the implicit receiver cache for the return address
	 of a call to the ceImplicitReceiverTrampoline."
	<option: #NewspeakVM>
	<inline: false>
	^self literalBeforeFollowingAddress: callSiteReturnAddress - 10