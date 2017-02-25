inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceding callSiteReturnAddress will jump to."
	| callDistance |
	callDistance := self literal32BeforeFollowingAddress: callSiteReturnAddress.
	^callSiteReturnAddress + callDistance signedIntFromLong