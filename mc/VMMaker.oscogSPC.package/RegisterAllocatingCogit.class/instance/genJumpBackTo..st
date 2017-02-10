bytecode generator support
genJumpBackTo: targetBytecodePC
	| nothingToFlush label |
	<var: #label type: #'AbstractInstruction *'>
	"If there's nothing to flush then the stack state at this point is the same as that after
	 the check for interrups and we can avoid generating the register reload code twice."
	(nothingToFlush := simStackPtr < 0 or: [self ssTop spilled]) ifTrue:
		[label := self Label].
	self reconcileRegisterStateForBackwardJoin: (self fixupAt: targetBytecodePC - initialPC).
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpAboveOrEqual: (self fixupAt: targetBytecodePC - initialPC).

	self ssFlushTo: simStackPtr.
	self CallRT: ceCheckForInterruptTrampoline.
	self annotateBytecode: self Label.
	nothingToFlush
		ifTrue:
			[self Jump: label]
		ifFalse:
			[self reconcileRegisterStateForBackwardJoin: (self fixupAt: targetBytecodePC - initialPC).
			 self Jump: (self fixupAt: targetBytecodePC - initialPC)].
	deadCode := true. "can't fall through"
	^0