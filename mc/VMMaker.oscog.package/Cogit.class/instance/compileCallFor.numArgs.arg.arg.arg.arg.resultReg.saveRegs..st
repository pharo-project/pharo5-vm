initialization
compileCallFor: aRoutine numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 resultReg: resultRegOrNil saveRegs: saveRegs
	"Generate a call to aRoutine with up to 4 arguments.  If resultRegOrNil is
	 non-zero assign the C result to resultRegOrNil.  If saveRegs, save all registers.
	 Hack: a negative arg value indicates an abstract register, a non-negative value
	 indicates a constant."
	<var: #aRoutine type: #'void *'>
	<inline: false>
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
	self CallRT: (self cCode: [aRoutine asUnsignedInteger]
					   inSmalltalk: [self simulatedTrampolineFor: aRoutine]).
	resultRegOrNil ifNotNil:
		[backEnd genWriteCResultIntoReg: resultRegOrNil].
	 saveRegs ifTrue:
		[numArgs > 0 ifTrue:
			[backEnd genRemoveNArgsFromStack: numArgs].
		resultRegOrNil
			ifNotNil: [backEnd genRestoreRegsExcept: resultRegOrNil]
			ifNil: [backEnd genRestoreRegs]]