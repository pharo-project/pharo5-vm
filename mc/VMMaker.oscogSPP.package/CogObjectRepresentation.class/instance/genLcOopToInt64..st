inline primitive support
genLcOopToInt64: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: ceSigned64BitValueOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushNativeRegister: ReceiverResultReg.