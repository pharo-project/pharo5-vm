inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceeding callSiteReturnAddress will jump to."
	"this is also used by #jumpLongTargetBeforeFOllowingAddress: and so we check for both call and jump related instructions; later on we can use simpler tests once it feels safe to assume we get here always with a call/jump in the proper place"
	| callDistance call |
	call := self instructionBeforeAddress: callSiteReturnAddress.
	self assert: call ~= 0. "andeq r0, r0 will not be generated, not even as nops"
	((self instructionIsB: call) or:[self instructionIsBL: call])
		ifTrue: [ "a short call/jump" callDistance := self extractOffsetFromBL: call.
			^callSiteReturnAddress + 4 + callDistance signedIntFromLong].
	
	((self instructionIsBX: call) or:[self instructionIsBLX: call])
		ifTrue:["A Long Call/Jump. Extract the value saved to RISCTempReg from all the instructions before."
			^self extractOffsetFromBXAt: callSiteReturnAddress - 4].
	self halt
	