initialization
genTraceStoreTrampoline
	ceTraceStoreTrampoline := self genSafeTrampolineFor: #ceTraceStoreOf:into:
										called: 'ceTraceStoreTrampoline'
										arg: ClassReg
										arg: ReceiverResultReg