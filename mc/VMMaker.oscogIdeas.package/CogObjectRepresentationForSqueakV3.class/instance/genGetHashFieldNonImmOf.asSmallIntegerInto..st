compile abstract instructions
genGetHashFieldNonImmOf: instReg asSmallIntegerInto: destReg
	"Fetch the instance's identity hash into destReg, encoded as a SmallInteger."
	"Get header word in scratchReg"
	cogit MoveMw: 0 r: instReg R: destReg.
	"Shift and mask the field leaving room for the SmallInteger tag."
	cogit LogicalShiftRightCq: HashBitsOffset - 1 R: destReg.
	cogit AndCq: HashMaskUnshifted << 1 R: destReg.
	"Set the SmallInteger tag."
	cogit AddCq: 1 R: destReg.
	^0