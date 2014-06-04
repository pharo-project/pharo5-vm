compile abstract instructions
genGetCompactClassIndexNonImmOf: instReg into: destReg
	"Fetch the instance's compact class index into destReg."
	"Get header word in scratchReg"
	cogit MoveMw: 0 r: instReg R: destReg.
	"Form the byte index of the compact class field"
	cogit LogicalShiftRightCq: objectMemory compactClassFieldLSB R: destReg.
	cogit AndCq: self compactClassFieldMask R: destReg.
	^0