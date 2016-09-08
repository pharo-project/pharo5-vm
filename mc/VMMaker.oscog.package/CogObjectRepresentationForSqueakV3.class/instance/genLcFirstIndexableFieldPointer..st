inline primitive support
genLcFirstIndexableFieldPointer: objectReg
	<option: #LowcodeVM>
	"TODO: Fixme for fixed fields"
	cogit AddCq: 4 R: objectReg.
	cogit ssPushNativeRegister: objectReg.