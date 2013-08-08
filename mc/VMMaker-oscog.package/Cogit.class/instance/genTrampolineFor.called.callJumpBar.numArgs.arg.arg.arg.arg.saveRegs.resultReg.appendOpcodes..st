initialization
genTrampolineFor: aRoutine called: trampolineName callJumpBar: callJumpBar "<Boolean>" numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 saveRegs: saveRegs resultReg: resultRegOrNil appendOpcodes: appendBoolean
	"Generate a trampoline with up to four arguments.  Generate either a call or a jump to aRoutineOrNil
	 as requested by callJumpBar.  If generating a call and resultRegOrNil is non-zero pass the C result
	 back in resultRegOrNil.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #trampolineName type: #'char *'>
	| startAddress |
	<inline: false>
	startAddress := methodZoneBase.
	appendBoolean ifFalse:
		[opcodeIndex := 0].
	self compileTrampolineFor: aRoutine
		callJumpBar: callJumpBar
		numArgs: numArgs
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: regOrConst3
		saveRegs: saveRegs
		resultReg: resultRegOrNil.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: trampolineName address: startAddress.
	self recordRunTimeObjectReferences.
	^startAddress