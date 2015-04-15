compile abstract instructions
genGetBits: mask ofFormatByteOf: sourceReg into: destReg baseHeaderIntoScratch: scratchReg
	scratchReg
		ifNil:
			[self flag: #endianness.
			 cogit MoveMb: 3 r: sourceReg R: destReg]
		ifNotNil:
			[cogit MoveMw: 0 r: sourceReg R: destReg.
			 cogit MoveR: destReg R: scratchReg. "destReg := (at least) least significant half of self baseHeader: receiver"
			 cogit LogicalShiftRightCq: objectMemory formatShift R: destReg].
	cogit AndCq: mask R: destReg.	"formatReg := self formatOfHeader: destReg"
	^0