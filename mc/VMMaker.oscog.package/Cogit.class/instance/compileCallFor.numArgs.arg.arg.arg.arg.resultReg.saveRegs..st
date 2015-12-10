initialization
compileCallFor: aRoutine numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 resultReg: resultRegOrNone saveRegs: saveRegs
	"Generate a call to aRoutine with up to 4 arguments.  If resultRegOrNone is not
	 NoReg assign the C result to resultRegOrNone.  If saveRegs, save all registers.
	 Hack: a negative arg value indicates an abstract register, a non-negative value
	 indicates a constant."
	<var: #aRoutine type: #'void *'>
	<inline: false>
	cStackAlignment > objectMemory wordSize ifTrue:
		[backEnd
			genAlignCStackSavingRegisters: saveRegs
			numArgs: numArgs
			wordAlignment: cStackAlignment / objectMemory wordSize].
	saveRegs ifTrue:
		[backEnd genSaveRegisters].
	backEnd genMarshallNArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3.
	self CallFullRT: (self cCode: [aRoutine asUnsignedInteger]
					   inSmalltalk: [self simulatedTrampolineFor: aRoutine]).
	resultRegOrNone ~= NoReg ifTrue:
		[backEnd genWriteCResultIntoReg: resultRegOrNone].
	 saveRegs ifTrue:
		[numArgs > 0 ifTrue:
			[backEnd genRemoveNArgsFromStack: numArgs].
		resultRegOrNone ~= NoReg
			ifTrue: [backEnd genRestoreRegsExcept: resultRegOrNone]
			ifFalse: [backEnd genRestoreRegs]]