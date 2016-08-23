initialization
genTraceStoreTrampoline
	ceTraceStoreTrampoline := self genTrampolineFor: #ceTraceStoreOf:into:
										called: 'ceTraceStoreTrampoline'
										arg: ClassReg
										arg: ReceiverResultReg
										regsToSave: CallerSavedRegisterMask