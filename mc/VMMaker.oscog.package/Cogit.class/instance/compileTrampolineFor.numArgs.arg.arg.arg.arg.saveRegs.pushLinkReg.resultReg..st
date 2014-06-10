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
	cStackAlignment > BytesPerWord ifTrue:
		[backEnd
			genAlignCStackSavingRegisters: saveRegs
			numArgs: numArgs
			wordAlignment: cStackAlignment / BytesPerWord].
	saveRegs ifTrue:
		[backEnd genSaveRegisters].
	numArgs > 0 ifTrue:
		[numArgs > 1 ifTrue:
			[numArgs > 2 ifTrue:
				[numArgs > 3 ifTrue:
					[regOrConst3 < 0
						ifTrue: [backEnd genPassReg: regOrConst3 asArgument: 3]
						ifFalse: [backEnd genPassConst: regOrConst3 asArgument: 3]].
				 regOrConst2 < 0
					ifTrue: [backEnd genPassReg: regOrConst2 asArgument: 2]
					ifFalse: [backEnd genPassConst: regOrConst2 asArgument: 2]].
			regOrConst1 < 0
				ifTrue: [backEnd genPassReg: regOrConst1 asArgument: 1]
				ifFalse: [backEnd genPassConst: regOrConst1 asArgument: 1]].
		regOrConst0 < 0
			ifTrue: [backEnd genPassReg: regOrConst0 asArgument: 0]
			ifFalse: [backEnd genPassConst: regOrConst0 asArgument: 0]].
	self Call: (self cCode: [aRoutine asUnsignedInteger]
					   inSmalltalk: [self simulatedTrampolineFor: aRoutine]).
	resultRegOrNil ifNotNil:
		[backEnd genWriteCResultIntoReg: resultRegOrNil].
	 saveRegs ifTrue:
		[numArgs > 0 ifTrue:
			[backEnd genRemoveNArgsFromStack: numArgs].
		resultRegOrNil
			ifNotNil: [backEnd genRestoreRegsExcept: resultRegOrNil]
			ifNil: [backEnd genRestoreRegs]].
	backEnd genLoadStackPointers.
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: 0