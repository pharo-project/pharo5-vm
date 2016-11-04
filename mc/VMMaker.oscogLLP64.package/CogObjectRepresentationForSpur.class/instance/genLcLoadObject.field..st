inline primitive support
genLcLoadObject: object field: fieldIndex
	<option: #LowcodeVM>
	cogit MoveMw: 8 + (BytesPerOop*fieldIndex) r: object R: object.
	cogit ssPushRegister: object