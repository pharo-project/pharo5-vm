inline primitive support
genLcLoadObject: object at: fieldIndex
	<option: #LowcodeVM>
	cogit AddCq: 1 R: fieldIndex.
	cogit MoveXwr: fieldIndex R: object R: object.
	cogit ssPushRegister: object