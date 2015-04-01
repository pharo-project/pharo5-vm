inline cacheing
implicitReceiveCacheAt: callSiteReturnAddress
	"Answer the implicit receiver cache for the return address
	 of a call to the ceImplicitReceiverTrampoline."
	<option: #NewspeakVM>
	<var: #callSiteReturnAddress type: #'char *'>
	<inline: false>
	^self literalBeforeFollowingAddress: callSiteReturnAddress asUnsignedInteger - 5 "sizeofcall"