compile abstract instructions
genGetFormatOf: sourceReg into: destReg leastSignificantHalfOfBaseHeaderIntoScratch: scratchRegOrNone
	"Get the format of the object in sourceReg into destReg.  If scratchRegOrNone
	 is not NoReg, load at least the least significant 32-bits (64-bits in 64-bits) of the
	 header word, which contains the format, into scratchRegOrNone."
	scratchRegOrNone = NoReg
		ifTrue:
			[self flag: #endianness.
			 cogit MoveMb: 3 r: sourceReg R: destReg]
		ifFalse:
			[cogit MoveMw: 0 r: sourceReg R: destReg.
			 cogit MoveR: destReg R: scratchRegOrNone. "destReg := (at least) least significant half of self baseHeader: receiver"
			 cogit LogicalShiftRightCq: objectMemory formatShift R: destReg].
	cogit AndCq: objectMemory formatMask R: destReg.	"formatReg := self formatOfHeader: destReg"
	^0