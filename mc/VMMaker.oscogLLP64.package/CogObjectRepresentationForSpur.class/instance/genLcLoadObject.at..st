inline primitive support
genLcLoadObject: object at: fieldIndex
	<option: #LowcodeVM>
	cogit AddCq: 8 R: object.
	cogit MoveXwr: fieldIndex R: object R: object.
	cogit ssPushRegister: object