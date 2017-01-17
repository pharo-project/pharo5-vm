inline primitive support
genLcInt32ToOop: value
	<option: #LowcodeVM>
	self genConvertIntegerToSmallIntegerInReg: value.
	cogit SignExtend32R: value R: value.
	cogit ssPushRegister: value.
	^ 0