initialization
generateObjectRepresentationTrampolines
	"Do the store check.  Answer the argument for the benefit of the code generator;
	 ReceiverResultReg may be caller-saved and hence smashed by this call.  Answering
	 it allows the code generator to reload ReceiverResultReg cheaply."
	ceStoreCheckTrampoline := cogit
									genTrampolineFor: #ceStoreCheck:
									called: 'ceStoreCheckTrampoline'
									arg: ReceiverResultReg
									result: cogit returnRegForStoreCheck.
	ceCreateNewArrayTrampoline := cogit genTrampolineFor: #ceNewArraySlotSize:
											called: 'ceCreateNewArrayTrampoline'
											arg: SendNumArgsReg
											result: ReceiverResultReg.
	cePositive32BitIntegerTrampoline := cogit genTrampolineFor: #positive32BitIntegerFor:
												called: 'cePositive32BitIntegerTrampoline'
												arg: ReceiverResultReg
												result: TempReg.
	ceActiveContextTrampoline := self genActiveContextTrampoline.
	ceClosureCopyTrampoline := cogit genTrampolineFor: #ceClosureCopyDescriptor:
										called: 'ceClosureCopyTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg