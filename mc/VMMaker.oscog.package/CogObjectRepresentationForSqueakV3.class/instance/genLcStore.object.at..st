inline primitive support
genLcStore: value object: object at: fieldIndex
	<option: #LowcodeVM>
	cogit AddCq: 1 R: fieldIndex.
	cogit MoveR: value Xwr: fieldIndex R: object