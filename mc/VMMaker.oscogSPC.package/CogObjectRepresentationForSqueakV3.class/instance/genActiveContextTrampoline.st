initialization
genActiveContextTrampoline
	"Short-circuit the interpreter call if a frame is already married."
	| jumpSingle |
	<var: #jumpSingle type: #'AbstractInstruction *'>
	cogit
		zeroOpcodeIndex;
		MoveMw: FoxMethod r: FPReg R: TempReg;
		AndCq: MFMethodFlagHasContextFlag R: TempReg.
	jumpSingle := cogit JumpZero: 0.
	cogit
		MoveMw: FoxThisContext r: FPReg R: ReceiverResultReg;
		RetN: 0.
	jumpSingle jmpTarget: cogit Label.
	^cogit genTrampolineFor: #ceActiveContext
		called: 'ceActiveContextTrampoline'
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		regsToSave: cogit emptyRegisterMask
		pushLinkReg: true
		resultReg: ReceiverResultReg
		appendOpcodes: true