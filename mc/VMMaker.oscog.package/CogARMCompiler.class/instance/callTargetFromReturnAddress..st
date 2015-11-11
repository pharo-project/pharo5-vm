inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address that the call immediately preceding callSiteReturnAddress will jump to."
	"this is also used by #jumpLongTargetBeforeFollowingAddress:."
	| callDistance call |
	call := self instructionBeforeAddress: callSiteReturnAddress.
	self assert: ((self instructionIsB: call) or: [self instructionIsBL: call]).
	callDistance := self extractOffsetFromBL: call.
	"this is the pc's +8 offset, - the 4 byte correction for the previous instruction address"
	^callSiteReturnAddress + 4  + callDistance signedIntFromLong