initialization
generateRunTimeTrampolines
	"Generate the run-time entries at the base of the native code zone and update the base."
	ceSendMustBeBooleanAddFalseTrampoline := self genMustBeBooleanTrampolineFor: objectMemory falseObject
														called: 'ceSendMustBeBooleanAddFalseTrampoline'.
	ceSendMustBeBooleanAddTrueTrampoline := self genMustBeBooleanTrampolineFor: objectMemory trueObject
														called: 'ceSendMustBeBooleanAddTrueTrampoline'.
	ceClosureCopyTrampoline := self genTrampolineFor: #ceClosureCopyDescriptor:
									called: 'ceClosureCopyTrampoline'
									arg: SendNumArgsReg
									result: ReceiverResultReg.
	ceActiveContextTrampoline := self genActiveContextTrampoline.
	ceNonLocalReturnTrampoline := self genNonLocalReturnTrampoline.
	ceBaseFrameReturnTrampoline := self genTrampolineFor: #ceBaseFrameReturn:
										called: 'ceBaseFrameReturnTrampoline'
										arg: ReceiverResultReg.
	ceCreateNewArrayTrampoline := self genTrampolineFor: #ceNewArraySlotSize:
										called: 'ceCreateNewArrayTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg.
	ceCheckForInterruptTrampoline := self genCheckForInterruptsTrampoline.
	ceStoreCheckTrampoline := objectRepresentation genStoreCheckTrampoline.
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
	cePositive32BitIntegerTrampoline := self genTrampolineFor: #cePositive32BitIntegerFor:
											called: 'cePositive32BitIntegerTrampoline'
											arg: ReceiverResultReg
											result: TempReg.
	ceReturnToInterpreterTrampoline := self genTrampolineFor: #ceReturnToInterpreter:
											called: 'ceReturnToInterpreterTrampoline'
											arg: ReceiverResultReg.
	ceCannotResumeTrampoline := self genTrampolineFor: #ceCannotResume
											called: 'ceCannotResumeTrampoline'