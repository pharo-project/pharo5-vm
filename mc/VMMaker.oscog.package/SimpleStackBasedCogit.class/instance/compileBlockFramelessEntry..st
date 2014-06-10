compile abstract instructions
compileBlockFramelessEntry: blockStart
	"Make sure ReceiverResultReg holds the receiver, loaded from the closure,
	 which is what is initially in ReceiverResultReg.  We must annotate the first
	 instruction so that findMethodForStartBcpc:inHomeMethod: can function.
	 We need two annotations because the first is a fiducial."
	<var: #blockStart type: #'BlockStart *'>
	self annotateBytecode: blockStart entryLabel.
	self annotateBytecode: blockStart entryLabel.
	objectRepresentation
		genLoadSlot: ClosureOuterContextIndex
			sourceReg: ReceiverResultReg
				destReg: TempReg;
		genLoadSlot: ReceiverIndex
			sourceReg: TempReg
				destReg: ReceiverResultReg