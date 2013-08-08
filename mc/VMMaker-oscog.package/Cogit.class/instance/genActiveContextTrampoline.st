initialization
genActiveContextTrampoline
	"Short-circuit the interpreter call if a frame is already married."
	| jumpSingle |
	<var: #jumpSingle type: #'AbstractInstruction *'>
	opcodeIndex := 0.
	self MoveMw: FoxMethod r: FPReg R: TempReg.
	self AndCq: MFMethodFlagHasContextFlag R: TempReg.
	jumpSingle := self JumpZero: 0.
	self MoveMw: FoxThisContext r: FPReg R: ReceiverResultReg.
	self RetN: 0.
	jumpSingle jmpTarget: self Label.
	^self genTrampolineFor: #ceActiveContext
		called: 'ceActiveContextTrampoline'
		callJumpBar: true
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		resultReg: ReceiverResultReg
		appendOpcodes: true