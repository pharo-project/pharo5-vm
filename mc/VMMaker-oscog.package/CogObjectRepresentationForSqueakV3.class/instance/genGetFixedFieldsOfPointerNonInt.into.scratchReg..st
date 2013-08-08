compile abstract instructions
genGetFixedFieldsOfPointerNonInt: instReg into: destReg scratchReg: scratchReg
	"Fetch the instance's class format into destReg, assuming the object is pointers and non-int"
	self genGetClassFormatOfNonInt: instReg into: destReg scratchReg: scratchReg.
	"compute  (classFormat >> 11 bitAnd: 16rC0) + (classFormat >> 2 bitAnd: 16r3F) - 1"
	cogit
		MoveR: destReg R: scratchReg;
		LogicalShiftRightCq: 2 R: destReg;
		LogicalShiftRightCq: 11 R: scratchReg;
		AndCq: 16r3F R: destReg;
		AndCq: 16rC0 R: scratchReg;
		SubCq: 1 R: destReg;
		AddR: scratchReg R: destReg.
	^0