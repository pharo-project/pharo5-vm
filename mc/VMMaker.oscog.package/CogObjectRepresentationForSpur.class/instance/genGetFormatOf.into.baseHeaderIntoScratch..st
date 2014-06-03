compile abstract instructions
genGetFormatOf: sourceReg into: destReg baseHeaderIntoScratch: scratchReg
	cogit MoveMw: 0 r: sourceReg R: destReg.
	scratchReg ifNotNil:
		[cogit MoveR: destReg R: scratchReg]. "destReg := (at least) least significant half of self baseHeader: receiver"
	cogit LogicalShiftRightCq: objectMemory formatShift R: destReg.
	cogit AndCq: objectMemory formatMask R: destReg.	"formatReg := self formatOfHeader: destReg"
	^0