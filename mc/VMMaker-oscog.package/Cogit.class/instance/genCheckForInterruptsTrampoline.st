initialization
genCheckForInterruptsTrampoline
	opcodeIndex := 0.
	self PopR: TempReg. "instruction pointer"
	self MoveR: TempReg Aw: coInterpreter instructionPointerAddress.
	^self genTrampolineFor: #ceCheckForInterrupts
		called: 'ceCheckForInterruptsTrampoline'
		callJumpBar: true
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		resultReg: nil
		appendOpcodes: true