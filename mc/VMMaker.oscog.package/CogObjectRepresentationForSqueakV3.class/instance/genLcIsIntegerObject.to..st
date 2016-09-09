inline primitive support
genLcIsIntegerObject: objectReg to: valueReg
	<option: #LowcodeVM>
	"TODO: Support larger integers"
	cogit AndCq: 1 R: objectReg.
	cogit ssPushNativeRegister: objectReg.