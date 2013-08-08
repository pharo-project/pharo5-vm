inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceeding callSiteReturnAddress will jump to."
	| callDistance |
	callDistance := self literalBeforeFollowingAddress: callSiteReturnAddress.
	^callSiteReturnAddress + callDistance signedIntFromLong