inline primitive support
genLcFloat32: value toOop: object
	<option: #LowcodeVM>
	cogit ConvertRs: value Rd: DPFPReg0.
	cogit CallRT: ceFloatObjectOfTrampoline.

	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit ssPushRegister: ReceiverResultReg.