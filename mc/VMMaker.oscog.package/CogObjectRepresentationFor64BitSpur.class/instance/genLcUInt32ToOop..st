inline primitive support
genLcUInt32ToOop: value
	<option: #LowcodeVM>
	self genConvertIntegerToSmallIntegerInReg: value.
	cogit ZeroExtend32R: value R: value.
	cogit ssPushRegister: value.
	^ 0