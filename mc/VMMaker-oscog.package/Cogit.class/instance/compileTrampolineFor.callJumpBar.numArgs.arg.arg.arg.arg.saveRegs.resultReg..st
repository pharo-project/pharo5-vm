initialization
compileTrampolineFor: aRoutine callJumpBar: callJumpBar "<Boolean>" numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 saveRegs: saveRegs resultReg: resultRegOrNil
	"Generate a trampoline with up to four arguments.  Generate either a call or a jump to aRoutine
	 as requested by callJumpBar.  If generating a call and resultRegOrNil is non-zero pass the C result
	 back in resultRegOrNil.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<inline: false>
	"If on a RISC processor the return address needs to be pushed to the
	 stack so that the interpreter sees the same stack layout as on CISC."
	backEnd hasLinkRegister ifTrue:
		[self PushR: LinkReg].
	self genSaveStackPointers.
	self genLoadCStackPointers.
	cStackAlignment > BytesPerWord ifTrue:
		[backEnd
			genAlignCStackSavingRegisters: saveRegs
			numArgs: numArgs
			wordAlignment: cStackAlignment / BytesPerWord].
	saveRegs ifTrue:
		[callJumpBar ifFalse:
			[self error: 'why save registers when you''re not going to return?'].
		 backEnd genSaveRegisters].
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
	self gen: (callJumpBar ifTrue: [Call] ifFalse: [Jump])
		operand: (self cCode: [aRoutine asUnsignedInteger]
					   inSmalltalk: [self simulatedTrampolineFor: aRoutine]).
	callJumpBar ifTrue:
		[resultRegOrNil ifNotNil:
			[backEnd genWriteCResultIntoReg: resultRegOrNil].
		 saveRegs ifTrue:
			[numArgs > 0 ifTrue:
				[backEnd genRemoveNArgsFromStack: numArgs].
			resultRegOrNil
				ifNotNil: [backEnd genRestoreRegsExcept: resultRegOrNil]
				ifNil: [backEnd genRestoreRegs]].
		self genLoadStackPointers.
		backEnd hasLinkRegister ifTrue:
			[self PopR: LinkReg].
		self RetN: 0]