initialization
generateObjectRepresentationTrampolines
	super generateObjectRepresentationTrampolines.
	ceCreateNewArrayTrampoline := cogit genTrampolineFor: #ceNewArraySlotSize:
											called: 'ceCreateNewArrayTrampoline'
											arg: SendNumArgsReg
											result: ReceiverResultReg.
	cePositive32BitIntegerTrampoline := cogit genTrampolineFor: #cePositive32BitIntegerFor:
												called: 'cePositive32BitIntegerTrampoline'
												arg: ReceiverResultReg
												result: TempReg.
	ceActiveContextTrampoline := self genActiveContextTrampoline.
	ceClosureCopyTrampoline := cogit genTrampolineFor: #ceClosureCopyDescriptor:
										called: 'ceClosureCopyTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg