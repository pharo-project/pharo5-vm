inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"Answer the address the call immediately preceeding callSiteReturnAddress will jump to."
	| callDistance call |
	call := self instructionBeforeAddress: callSiteReturnAddress.
	self assert: call ~= 0. "andeq r0, r0 will not be generated, not even as nops"
	(self isBranch: call)
		ifTrue: [ callDistance := (call bitAnd: 16r00FFFFFF) << 2.
			"The distance is a signed 24bit number. Therefore, the highest (26th) bit has to be expanded"
			(callDistance bitAnd: 16r02000000) ~= 0 
				ifTrue: [callDistance := callDistance bitOr: 16rFC000000]]
		ifFalse: [ "A Long Jump. Extract the value saved to RISCTempReg from all the instructions before."
			self notYetImplemented ].
	^callSiteReturnAddress + 4 + callDistance signedIntFromLong