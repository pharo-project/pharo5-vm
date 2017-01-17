inline primitive support
genLcInt32ToOop: value
	<option: #LowcodeVM>
	cogit SignExtend32R: value R: value.
	self genConvertIntegerToSmallIntegerInReg: value.
	cogit ssPushRegister: value.
	^ 0