bytecode generator support
genStorePop: popBoolean TemporaryVariable: tempIndex
	<inline: false>
	| srcRegOrNone destReg |
	self ssFlushUpThroughTemporaryVariable: tempIndex.
	"To avoid a stall writing through destReg, remember srcReg before the potential ssPop: 1 in ssStorePop:toReg:"
	srcRegOrNone := self ssTop registerOrNone.
	"ssStorePop:toPreferredReg: will allocate a register, and indeed may allocate ReceiverResultReg
	 if, for example, the ssEntry to be popped is already in ReceiverResultReg (as the result of a send).
	 ReceiverResultReg is not a good choice for a temporary variable; it has other uses.  So if the ssEntry
	 at top of stack has ReceiverResultReg as its live variable, try and allocate an alternative."
	((self ssTop type = SSConstant
	  or: [self ssTop registerMaskOrNone anyMask: self registerMaskUndesirableForTempVars])
	 and: [(destReg := self availableRegOrNoneNotConflictingWith: (self registerMaskUndesirableForTempVars bitOr: self liveRegisters)) ~= NoReg])
		ifTrue: [self ssStorePop: popBoolean toReg: destReg]
		ifFalse: [destReg := self ssStorePop: popBoolean toPreferredReg: TempReg].
	self MoveR: (srcRegOrNone ~= NoReg ifTrue: [srcRegOrNone] ifFalse: [destReg])
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	destReg ~= TempReg ifTrue:
		[(self simStackAt: tempIndex) liveRegister: destReg.
		 self copyLiveRegisterToCopiesOf: (self simStackAt: tempIndex)].
	^0