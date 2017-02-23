bytecode generator support
genJumpBackTo: targetPC
	| target |
	"We generate
				merge
				cmp stackLimit
				jumpAboveOrEqual target
				flush
				checkForInterrupts
				marge from flushed
				jmp target
	 self printSimStack; printSimStack: target mergeSimStack"
	self assert: targetPC < bytecodePC.
	target := self fixupAt: targetPC.
	self mergeCurrentSimStackWith: target forwards: false.
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