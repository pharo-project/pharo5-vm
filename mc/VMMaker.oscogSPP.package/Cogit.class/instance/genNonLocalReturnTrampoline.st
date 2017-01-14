initialization
genNonLocalReturnTrampoline
	self zeroOpcodeIndex.
	"write the return address to the coInterpreter instructionPointerAddress;
	 following the CallRT to this CISCs will have pushed it on the stack, so pop it first; RISCs will have it in
	 their link register so just write it directly."
	backEnd hasLinkRegister
		ifTrue:
			[self MoveR: LinkReg Aw: coInterpreter instructionPointerAddress]
		ifFalse:
			[self PopR: TempReg. "instruction pointer"
			 self MoveR: TempReg Aw: coInterpreter instructionPointerAddress].
	^self genTrampolineFor: #ceNonLocalReturn:
		called: 'ceNonLocalReturnTrampoline'
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false
		resultReg: NoReg
		appendOpcodes: true