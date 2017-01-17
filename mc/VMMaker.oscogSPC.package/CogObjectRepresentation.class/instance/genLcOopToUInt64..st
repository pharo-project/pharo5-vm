inline primitive support
genLcOopToUInt64: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: cePositive64BitValueOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushNativeRegister: ReceiverResultReg.