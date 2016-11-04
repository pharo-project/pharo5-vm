inline primitive support
genLcUInt64ToOop: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: cePositive64BitIntegerTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.