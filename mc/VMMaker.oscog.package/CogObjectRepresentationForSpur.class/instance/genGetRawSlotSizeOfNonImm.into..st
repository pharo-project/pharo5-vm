compile abstract instructions
genGetRawSlotSizeOfNonImm: sourceReg into: destReg
	"The raw numSlots field is the most significant byte of the 64-bit header word."
	cogit MoveMb: 7 r: sourceReg R: destReg.
	^0