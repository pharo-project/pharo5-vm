inline primitive support
genLcOopToPointer: object
	<option: #LowcodeVM>
	"Assume this is always correct"
	cogit MoveMw: BaseHeaderSize r: object R: object.
	cogit ssPushNativeRegister: object.