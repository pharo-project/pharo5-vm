initialization
genCheckForInterruptsTrampoline
	self zeroOpcodeIndex.
	"if we have a link register we will assume that it does not get automatically pushed onto the stack
	and thus there is no need to pop it before saving to instructionPointerAddress"
	backEnd hasLinkRegister
		ifTrue:
			[self MoveR: LinkReg Aw: coInterpreter instructionPointerAddress]
		ifFalse:
			[self PopR: TempReg. "instruction pointer"
			 self MoveR: TempReg Aw: coInterpreter instructionPointerAddress].
	^self genTrampolineFor: #ceCheckForInterrupts
		called: 'ceCheckForInterruptsTrampoline'
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false
		resultReg: NoReg
		appendOpcodes: true