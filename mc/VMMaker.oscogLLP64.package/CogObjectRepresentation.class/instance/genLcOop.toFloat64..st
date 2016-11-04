inline primitive support
genLcOop: object toFloat64: value
	<option: #LowcodeVM>
	object ~= ReceiverResultReg ifTrue: [ cogit MoveR: object R: ReceiverResultReg].
	cogit CallRT: ceFloatValueOfTrampoline.

	DPFPReg0 ~= value ifTrue: [cogit MoveRd: DPFPReg0 Rd: value.].
	cogit ssPushNativeRegisterDoubleFloat: value.