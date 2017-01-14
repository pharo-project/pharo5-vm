inline primitive support
genLcUInt32ToOop: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: cePositive32BitIntegerTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.