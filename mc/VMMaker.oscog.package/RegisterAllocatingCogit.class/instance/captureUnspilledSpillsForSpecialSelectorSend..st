bytecode generator support
captureUnspilledSpillsForSpecialSelectorSend: liveRegisterMask
	"Since we're allocating values in registers we would like to keep those registers live on the inlined path
	 and reload registers along the non-inlined send path.  But any values that would need to be spilled
	 along the non-inlined path must be captured before the split so that both paths can join.  If we don't
	 capture the values on the non-inlined path we could access stale values.  So for all stack entries that
	 would be spilled along the non-inlined path, assign them to registers, or spill if none are available."
	| i liveRegs reg |
	liveRegs := liveRegisterMask.
	optStatus isReceiverResultRegLive ifTrue:
		[liveRegs := liveRegs + (self registerMaskFor: ReceiverResultReg)].
	reg := TempReg. "Anything but NoReg"
	i := simStackPtr + 1. "We must spill a contiguous range at the hot top of stack, so we assign coldest first :-("
	[reg ~= NoReg and: [i > simSpillBase and: [i > 0]]] whileTrue:
		[i := i - 1.
		 self deny: ((self simStackAt: i) spilled and: [(self simStackAt: i) type = SSBaseOffset]).
		 ((self simStackAt: i) spilled not
		  and: [(self simStackAt: i) type = SSBaseOffset]) ifTrue:
			[reg := self allocateRegNotConflictingWith: liveRegs.
			 reg ~= NoReg ifTrue:
				[(self simStackAt: i) storeToReg: reg]]].
	reg = NoReg ifTrue:
		[self ssFlushTo: i]