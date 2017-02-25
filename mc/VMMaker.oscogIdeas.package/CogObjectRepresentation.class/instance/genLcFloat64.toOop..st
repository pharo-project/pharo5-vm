inline primitive support
genLcFloat64: value toOop: object
	<option: #LowcodeVM>
	value ~= DPFPReg0 ifTrue: [ cogit MoveRd: value Rd: DPFPReg0].
	cogit CallRT: ceFloatObjectOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.