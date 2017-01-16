inline primitive support
genLcOopToUInt32: value
	<option: #LowcodeVM>
	self genConvertSmallIntegerToIntegerInReg: value.
	cogit ssPushRegister: value.
	^ 0