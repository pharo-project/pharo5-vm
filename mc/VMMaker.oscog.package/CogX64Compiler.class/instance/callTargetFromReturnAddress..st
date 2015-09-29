inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceding callSiteReturnAddress will jump to."
	| callDistance |
	callDistance := self thirtyTwoBitLiteralBefore: callSiteReturnAddress.
	^callSiteReturnAddress + callDistance signedIntFromLong