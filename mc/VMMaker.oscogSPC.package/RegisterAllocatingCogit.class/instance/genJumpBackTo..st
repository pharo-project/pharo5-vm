bytecode generator support
genJumpBackTo: targetBytecodePC
	| nothingToFlush label |
	<var: #label type: #'AbstractInstruction *'>
	"If there's nothing to flush then the stack state at this point is the same as that after
	 the check for interrupts and we can avoid generating the register reload code twice."
	nothingToFlush := (self liveRegisters bitClear: (self registerMaskFor: FPReg)) = 0.
	nothingToFlush ifTrue:
		[label := self Label].
	self reconcileRegisterStateForBackwardJoin: (self fixupAt: targetBytecodePC).
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpAboveOrEqual: (self fixupAt: targetBytecodePC).

	self ssFlushTo: simStackPtr.
	self CallRT: ceCheckForInterruptTrampoline.
	self annotateBytecode: self Label.
	self flushLiveRegistersForSuspensionPoint.
	nothingToFlush
		ifTrue:
			[self Jump: label]
		ifFalse:
			[self reconcileRegisterStateForBackwardJoin: (self fixupAt: targetBytecodePC).
			 self Jump: (self fixupAt: targetBytecodePC)].
	deadCode := true. "can't fall through"
	^0