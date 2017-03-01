bytecode generator support
genStorePop: popBoolean TemporaryVariable: tempIndex
	<inline: false>
	| top srcRegOrNone destReg |
	self deny: self duplicateRegisterAssignmentsInTemporaries.
	self ssFlushUpThroughTemporaryVariable: tempIndex.
	"To avoid a stall writing through destReg, remember srcReg before the potential ssPop: 1 in ssStorePop:toReg:"
	top := self ssTop.
	srcRegOrNone := top registerOrNone.
	"ssStorePop:toPreferredReg: will allocate a register, and indeed may allocate ReceiverResultReg
	 if, for example, the ssEntry to be popped is already in ReceiverResultReg (as the result of a send).
	 ReceiverResultReg is not a good choice for a temporary variable; it has other uses.  So if the ssEntry
	 at top of stack has ReceiverResultReg as its live variable, try and allocate an alternative."
	destReg := (self simStackAt: tempIndex) liveRegister.
	destReg ~= NoReg
		ifTrue:
			[self ssStorePop: popBoolean toReg: destReg]
		ifFalse:
			[((top type = SSConstant
			    or: [srcRegOrNone = NoReg
			    or: [self register: srcRegOrNone isInMask: self registerMaskUndesirableForTempVars]])
			  and: [(destReg := self availableRegOrNoneNotConflictingWith: (self registerMaskUndesirableForTempVars bitOr: self liveRegisters)) ~= NoReg])
				ifTrue: [self ssStorePop: popBoolean toReg: destReg]
				ifFalse: [destReg := self ssStorePop: popBoolean toPreferredReg: TempReg].
			 "The ssStorePop: may end up assigning a register to ssTop, and if it is also a temp then a new
			  register must be found for the destination temp, sicne two temp vars can't share a register."
			 (top isFrameTempVar and: [top liveRegister = destReg]) ifTrue:
				[srcRegOrNone := destReg.
				 destReg := self availableRegOrNoneNotConflictingWith: (self registerMaskUndesirableForTempVars bitOr: self liveRegisters).
				 destReg ~= NoReg ifTrue:
					[self MoveR: srcRegOrNone R: destReg]].
			 (destReg ~= NoReg and: [destReg ~= TempReg]) ifTrue:
				[(self simStackAt: tempIndex) liveRegister: destReg.
				 self copyLiveRegisterToCopiesOf: (self simStackAt: tempIndex)]].
	self MoveR: (srcRegOrNone ~= NoReg ifTrue: [srcRegOrNone] ifFalse: [destReg])
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	(self simStackAt: tempIndex) bcptr: bytecodePC. "for debugging"
	self deny: self duplicateRegisterAssignmentsInTemporaries.
	^0