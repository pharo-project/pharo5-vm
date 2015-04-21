inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address that the call immediately preceeding callSiteReturnAddress will jump to."
	"this is also used by #jumpLongTargetBeforeFollowingAddress:."
	| callDistance call |
	call := self instructionBeforeAddress: callSiteReturnAddress.
	self assert: ((self instructionIsB: call) or: [self instructionIsBL: call]).
	callDistance := self extractOffsetFromBL: call.
	^callSiteReturnAddress + 4 + callDistance signedIntFromLong