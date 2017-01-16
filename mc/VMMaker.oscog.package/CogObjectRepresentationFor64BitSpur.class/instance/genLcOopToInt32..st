inline primitive support
genLcOopToInt32: value
	<option: #LowcodeVM>
	self genConvertSmallIntegerToIntegerInReg: value.
	cogit ssPushRegister: value.
	^ 0