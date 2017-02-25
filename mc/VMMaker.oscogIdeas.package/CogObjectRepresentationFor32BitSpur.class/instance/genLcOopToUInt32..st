inline primitive support
genLcOopToUInt32: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: cePositive32BitValueOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushNativeRegister: ReceiverResultReg.