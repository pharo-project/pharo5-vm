inline primitive support
genLcInt32ToOop: value
	<option: #LowcodeVM>
	value ~= ReceiverResultReg ifTrue: [ cogit MoveR: value R: ReceiverResultReg.].
	cogit CallRT: ceSigned32BitIntegerTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.