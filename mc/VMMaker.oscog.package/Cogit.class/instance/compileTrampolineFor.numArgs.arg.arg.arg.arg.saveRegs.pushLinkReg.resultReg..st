initialization
compileTrampolineFor: aRoutine numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 saveRegs: saveRegs pushLinkReg: pushLinkReg resultReg: resultRegOrNil
	"Generate a trampoline with up to four arguments.  Generate either a call or a jump to aRoutine
	 as requested by callJumpBar.  If generating a call and resultRegOrNil is non-zero pass the C result
	 back in resultRegOrNil.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<inline: false>
	"If on a RISC processor, the return address needs to be pushed to the
	 stack so that the interpreter sees the same stack layout as on CISC."
	(pushLinkReg and: [backEnd hasLinkRegister]) ifTrue:
		[self PushR: LinkReg].
	self genSmalltalkToCStackSwitch.
	self
		compileCallFor: aRoutine
		numArgs: numArgs
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: regOrConst3
		resultReg: resultRegOrNil
		saveRegs: saveRegs.
	backEnd genLoadStackPointers.
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: 0