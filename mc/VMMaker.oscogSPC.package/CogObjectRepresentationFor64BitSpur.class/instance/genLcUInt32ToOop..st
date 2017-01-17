inline primitive support
genLcUInt32ToOop: value
	<option: #LowcodeVM>
	cogit ZeroExtend32R: value R: value.
	self genConvertIntegerToSmallIntegerInReg: value.
	cogit ssPushRegister: value.
	^ 0