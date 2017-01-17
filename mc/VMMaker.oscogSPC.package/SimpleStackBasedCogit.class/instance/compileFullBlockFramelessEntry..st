compile abstract instructions
compileFullBlockFramelessEntry: numCopied 
	"Make sure ReceiverResultReg holds the receiver, loaded from the closure,
	 which is what is initially in ReceiverResultReg.  "
	"Use ReceiverResultReg for Context to agree with store check trampoline"
	objectRepresentation
		genLoadSlot: ClosureOuterContextIndex
			sourceReg: ReceiverResultReg
				destReg: ReceiverResultReg;
		genLoadSlot: ReceiverIndex
			sourceReg: ReceiverResultReg
				destReg: Arg0Reg.
	self flag: #TODO. "we could follow the receiver only if the block has inst var ref. Currently we use scanMethod for fullBlock 
	and that scanner does not provide this information. We could extend it based on the scanBlock: method"
	objectRepresentation
		genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg updatingSlot: ReceiverIndex in: ReceiverResultReg.
	self MoveR: Arg0Reg R: ReceiverResultReg
