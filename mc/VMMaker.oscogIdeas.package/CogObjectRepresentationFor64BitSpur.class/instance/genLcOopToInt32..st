inline primitive support
genLcOopToInt32: value
	<option: #LowcodeVM>
	self genConvertSmallIntegerToIntegerInReg: value.
	cogit ssPushNativeRegister: value.
	^ 0