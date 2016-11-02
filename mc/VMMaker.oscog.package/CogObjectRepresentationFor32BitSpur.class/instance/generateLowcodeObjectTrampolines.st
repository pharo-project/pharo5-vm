initialization
generateLowcodeObjectTrampolines
	<option: #LowcodeVM>
	super generateLowcodeObjectTrampolines.
	cePositive32BitIntegerTrampoline := cogit genTrampolineFor: #positive32BitIntegerFor:
												called: 'cePositive32BitIntegerTrampoline'
												arg: ReceiverResultReg
												result: TempReg.
	cePositive32BitValueOfTrampoline := cogit genTrampolineFor: #positive32BitValueOf:
												called: 'cePositive32BitValueOfTrampoline'
												arg: ReceiverResultReg
												result: TempReg.
	ceSigned32BitIntegerTrampoline := cogit genTrampolineFor: #signed32BitIntegerFor:
												called: 'ceSigned32BitIntegerTrampoline'
												arg: ReceiverResultReg
												result: TempReg.
	ceSigned32BitValueOfTrampoline := cogit genTrampolineFor: #signed32BitValueOf:
												called: 'ceSigned32BitValueOfTrampoline'
												arg: ReceiverResultReg
												result: TempReg.