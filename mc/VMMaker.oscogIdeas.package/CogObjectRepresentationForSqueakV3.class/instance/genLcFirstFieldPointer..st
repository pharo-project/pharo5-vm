inline primitive support
genLcFirstFieldPointer: objectReg
	<option: #LowcodeVM>
	cogit AddCq: 4 R: objectReg.
	cogit ssPushNativeRegister: objectReg.