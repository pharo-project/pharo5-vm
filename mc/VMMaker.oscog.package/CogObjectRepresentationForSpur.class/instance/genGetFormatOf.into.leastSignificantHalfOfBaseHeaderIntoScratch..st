compile abstract instructions
genGetFormatOf: sourceReg into: destReg leastSignificantHalfOfBaseHeaderIntoScratch: scratchRegOrNil
	"Get the format of the object in sourceReg into destReg.  If scratchRegOrNil
	 is not nil, load at least the least significant 32-bits (64-bits in 64-bits) of the
	 header word, which contains the format, into scratchRegOrNil."
	scratchRegOrNil
		ifNil:
			[self flag: #endianness.
			 cogit MoveMb: 3 r: sourceReg R: destReg]
		ifNotNil:
			[cogit MoveMw: 0 r: sourceReg R: destReg.
			 cogit MoveR: destReg R: scratchRegOrNil. "destReg := (at least) least significant half of self baseHeader: receiver"
			 cogit LogicalShiftRightCq: objectMemory formatShift R: destReg].
	cogit AndCq: objectMemory formatMask R: destReg.	"formatReg := self formatOfHeader: destReg"
	^0