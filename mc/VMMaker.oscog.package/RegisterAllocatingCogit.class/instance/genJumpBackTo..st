bytecode generator support
genJumpBackTo: targetPC
	| target |
	"On first pass install register allocations (if any) as of the end of the loop and back up to recompile.
	 One the second pass generate
				(any merge elided because register assignments copied to loop head in first pass)
				cmp stackLimit
				jumpAboveOrEqual target
				flush
				checkForInterrupts
				merge from flushed (N.B. If stack was flushed before loop we could conceivably jump to the pre-loop merge code)
				jmp target
	 self printSimStack; printSimStack: target mergeSimStack"
	self assert: targetPC < bytecodePC.
	target := self fixupAt: targetPC.
	self ensureRegisterAssignmentsAreAtHeadOfLoop: target.
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpAboveOrEqual: target.

	self ssFlushTo: simStackPtr.
	self CallRT: ceCheckForInterruptTrampoline.
	self annotateBytecode: self Label.
	self flushLiveRegistersForSuspensionPoint.
	self mergeCurrentSimStackWith: target forwards: false.
	self Jump: target.
	deadCode := true. "can't fall through"
	^0