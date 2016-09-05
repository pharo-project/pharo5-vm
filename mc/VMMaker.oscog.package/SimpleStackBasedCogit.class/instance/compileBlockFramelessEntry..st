compile abstract instructions
compileBlockFramelessEntry: blockStart
	"Make sure ReceiverResultReg holds the receiver, loaded from the closure,
	 which is what is initially in ReceiverResultReg.  We must annotate the first
	 instruction in vanilla blocks so that findMethodForStartBcpc:inHomeMethod:
	 can function. We need two annotations because the first is a fiducial."
	<var: #blockStart type: #'BlockStart *'>
	blockStart entryLabel ifNotNil:
		[self annotateBytecode: blockStart entryLabel.
		 self annotateBytecode: blockStart entryLabel].
	blockStart hasInstVarRef
		ifTrue: "Use ReceiverResultReg for Context to agree with store check trampoline"
			[objectRepresentation
				genLoadSlot: ClosureOuterContextIndex
					sourceReg: ReceiverResultReg
						destReg: ReceiverResultReg;
				genLoadSlot: ReceiverIndex
					sourceReg: ReceiverResultReg
						destReg: Arg0Reg.
			objectRepresentation
				genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg updatingSlot: ReceiverIndex in: ReceiverResultReg.
			self MoveR: Arg0Reg R: ReceiverResultReg]
		ifFalse:
			[objectRepresentation
				genLoadSlot: ClosureOuterContextIndex
					sourceReg: ReceiverResultReg
						destReg: TempReg;
				genLoadSlot: ReceiverIndex
					sourceReg: TempReg
						destReg: ReceiverResultReg].