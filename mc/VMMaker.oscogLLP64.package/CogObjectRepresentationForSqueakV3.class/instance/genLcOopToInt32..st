inline primitive support
genLcOopToInt32: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: ceSigned32BitValueOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushNativeRegister: ReceiverResultReg.