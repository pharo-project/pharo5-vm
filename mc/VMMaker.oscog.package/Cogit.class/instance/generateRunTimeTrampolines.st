initialization
generateRunTimeTrampolines
	"Generate the run-time entries at the base of the native code zone and update the base."
	
	ceSendMustBeBooleanAddFalseTrampoline := self genMustBeBooleanTrampolineFor: objectMemory falseObject
														called: 'ceSendMustBeBooleanAddFalseTrampoline'.
	ceSendMustBeBooleanAddTrueTrampoline := self genMustBeBooleanTrampolineFor: objectMemory trueObject
														called: 'ceSendMustBeBooleanAddTrueTrampoline'.
	ceNonLocalReturnTrampoline := self genNonLocalReturnTrampoline.
	ceBaseFrameReturnTrampoline := self genTrampolineFor: #ceBaseFrameReturn:
										called: 'ceBaseFrameReturnTrampoline'
										arg: ReceiverResultReg.
	ceCheckForInterruptTrampoline := self genCheckForInterruptsTrampoline.
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
											result: ReceiverResultReg. "to keep ReceiverResultReg live."
	ceReturnToInterpreterTrampoline := self genTrampolineFor: #ceReturnToInterpreter:
											called: 'ceReturnToInterpreterTrampoline'
											arg: ReceiverResultReg.
	ceCannotResumeTrampoline := self genTrampolineFor: #ceCannotResume
											called: 'ceCannotResumeTrampoline'