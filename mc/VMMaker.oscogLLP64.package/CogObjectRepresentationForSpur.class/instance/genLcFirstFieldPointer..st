inline primitive support
genLcFirstFieldPointer: objectReg
	<option: #LowcodeVM>
	cogit AddCq: 8 R: objectReg.
	cogit ssPushNativeRegister: objectReg.