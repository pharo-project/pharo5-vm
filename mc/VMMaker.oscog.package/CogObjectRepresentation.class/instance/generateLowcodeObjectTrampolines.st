initialization
generateLowcodeObjectTrampolines
	<option: #LowcodeVM>
	ceFloatObjectOfTrampoline := cogit genTrampolineFor: #floatObjectOf:
												called: 'ceFloatObjectOfTrampoline'
												floatArg: DPFPReg0
												result: TempReg.
	ceFloatValueOfTrampoline := cogit genTrampolineFor: #floatValueOf:
												called: 'ceFloatValueOfTrampoline'
												arg: ReceiverResultReg
												floatResult: DPFPReg0.
	ceInstantiateClassIndexableSizeTrampoline := cogit genTrampolineFor: #instantiateClass:indexableSize:
												called: 'ceInstantiateClassIndexableSizeTrampoline'
												arg: Arg0Reg
												arg: Arg1Reg
												result: TempReg.
	ceInstantiateClassTrampoline := cogit genTrampolineFor: #instantiateClass:indexableSize:
												called: 'ceInstantiateClassTrampoline'
												arg: ReceiverResultReg
												arg: 0
												result: TempReg.
	ceByteSizeOfTrampoline := cogit genTrampolineFor: #byteSizeOf:
												called: 'ceByteSizeOfTrampoline'
												arg: Arg0Reg
												result: TempReg.
	BytesPerOop = 4 ifTrue: [
		cePositive64BitIntegerTrampoline := cogit genTrampolineFor: #positive64BitIntegerFor:
													called: 'cePositive64BitIntegerTrampoline'
													arg: ReceiverResultReg
													arg: Arg0Reg
													result: TempReg.
		cePositive64BitValueOfTrampoline := cogit genTrampolineFor: #positive64BitValueOf:
													called: 'cePositive64BitValueOfTrampoline'
													arg: ReceiverResultReg
													result: TempReg
													result: Arg0Reg.
		ceSigned64BitIntegerTrampoline := cogit genTrampolineFor: #signed64BitIntegerFor:
													called: 'ceSigned64BitIntegerTrampoline'
													arg: ReceiverResultReg
													arg: Arg0Reg
													result: TempReg.
		ceSigned64BitValueOfTrampoline := cogit genTrampolineFor: #signed64BitValueOf:
													called: 'ceSigned64BitValueOfTrampoline'
													arg: ReceiverResultReg
													result: TempReg
													result: Arg0Reg.
	] ifFalse: [
		cePositive64BitIntegerTrampoline := cogit genTrampolineFor: #positive64BitIntegerFor:
													called: 'cePositive64BitIntegerTrampoline'
													arg: ReceiverResultReg
													result: TempReg.
		cePositive64BitValueOfTrampoline := cogit genTrampolineFor: #positive64BitValueOf:
													called: 'cePositive64BitValueOfTrampoline'
													arg: ReceiverResultReg
													result: TempReg.
		ceSigned64BitIntegerTrampoline := cogit genTrampolineFor: #signed64BitIntegerFor:
													called: 'ceSigned64BitIntegerTrampoline'
													arg: ReceiverResultReg
													result: TempReg.
		ceSigned64BitValueOfTrampoline := cogit genTrampolineFor: #signed64BitValueOf:
													called: 'ceSigned64BitValueOfTrampoline'
													arg: ReceiverResultReg
													result: TempReg.
	]