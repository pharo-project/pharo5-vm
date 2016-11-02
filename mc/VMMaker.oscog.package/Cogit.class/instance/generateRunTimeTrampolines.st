initialization
generateRunTimeTrampolines
	"Generate the run-time entries at the base of the native code zone and update the base."
	
	ceSendMustBeBooleanAddFalseTrampoline := self genMustBeBooleanTrampolineFor: objectMemory falseObject
														called: 'ceSendMustBeBooleanAddFalseTrampoline'.
	ceSendMustBeBooleanAddTrueTrampoline := self genMustBeBooleanTrampolineFor: objectMemory trueObject
														called: 'ceSendMustBeBooleanAddTrueTrampoline'.
	ceNonLocalReturnTrampoline := self genNonLocalReturnTrampoline.
	ceCheckForInterruptTrampoline := self genCheckForInterruptsTrampoline.
	"Neither of the context inst var access trampolines save registers.  Their operation could cause
	 arbitrary update of stack frames, so the assumption is that callers flush the stack before calling
	 the context inst var access trampolines, and that everything except the result is dead afterwards."
	ceFetchContextInstVarTrampoline := self genTrampolineFor: #ceContext:instVar:
											called: 'ceFetchContextInstVarTrampoline'
											arg: ReceiverResultReg
											arg: SendNumArgsReg
											result: SendNumArgsReg.
	ceStoreContextInstVarTrampoline := self genTrampolineFor: #ceContext:instVar:value:
											called: 'ceStoreContextInstVarTrampoline'
											arg: ReceiverResultReg
											arg: SendNumArgsReg
											arg: ClassReg
											result: ReceiverResultReg. "to keep ReceiverResultReg live.".
	ceCannotResumeTrampoline := self genTrampolineFor: #ceCannotResume
											called: 'ceCannotResumeTrampoline'.
	"These two are unusual; they are reached by return instructions."
	ceBaseFrameReturnTrampoline := self genReturnTrampolineFor: #ceBaseFrameReturn:
											called: 'ceBaseFrameReturnTrampoline'
											arg: ReceiverResultReg.
	ceReturnToInterpreterTrampoline := self
											genReturnTrampolineFor: #ceReturnToInterpreter:
											called: 'ceReturnToInterpreterTrampoline'
											arg: ReceiverResultReg.
	ceMallocTrampoline := self genTrampolineFor: #ceMalloc:
											called: 'ceMallocTrampoline'
											arg: ReceiverResultReg
											result: TempReg.
	ceFreeTrampoline := self genTrampolineFor: #ceFree:
											called: 'ceFreeTrampoline'
											arg: ReceiverResultReg.
	LowcodeVM ifTrue: [
		ceFFICalloutTrampoline := self genFFICalloutTrampoline.
	]