bytecode generator support
genStorePop: popBoolean TemporaryVariable: tempIndex
	<inline: false>
	| reg |
	self ssFlushUpThroughTemporaryVariable: tempIndex.
	"ssStorePop:toPreferredReg: will allocate a register, and indeed may allocate ReceiverResultReg
	 if, for example, the ssEntry to be popped is already in ReceiverResultReg (as the result of a send).
	 ReceiverResultReg is not a good choice for a temporary variable; it has other uses.  So if the ssEntry
	 at top of stack has ReceiverResultReg as its live variable, try and allocate an alternative."
	((self ssTop registerMaskOrNone anyMask: self registerMaskUndesirableForTempVars)
	 and: [(reg := self availableRegOrNoneNotConflictingWith:  self registerMaskUndesirableForTempVars) ~= NoReg])
		ifTrue: [self ssStorePop: popBoolean toReg: reg]
		ifFalse: [reg := self ssStorePop: popBoolean toPreferredReg: TempReg].
	self MoveR: reg
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	reg ~= TempReg ifTrue:
		[(self simStackAt: tempIndex) liveRegister: reg.
		 self copyLiveRegisterToCopiesOf: (self simStackAt: tempIndex)].
	^0