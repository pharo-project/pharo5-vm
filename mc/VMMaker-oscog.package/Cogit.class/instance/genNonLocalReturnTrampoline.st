initialization
genNonLocalReturnTrampoline
	opcodeIndex := 0.
	self PopR: TempReg. "instruction pointer"
	self MoveR: TempReg Aw: coInterpreter instructionPointerAddress.
	^self genTrampolineFor: #ceNonLocalReturn:
		called: 'ceNonLocalReturnTrampoline'
		callJumpBar: true
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		resultReg: nil
		appendOpcodes: true