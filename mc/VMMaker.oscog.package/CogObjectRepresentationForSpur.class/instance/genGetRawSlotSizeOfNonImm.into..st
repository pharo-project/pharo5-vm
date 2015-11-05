compile abstract instructions
genGetRawSlotSizeOfNonImm: sourceReg into: destReg
	"The raw numSlots field is the most significant byte of the 64-bit header word.
	 MoveMbrR zero-extends."
	cogit backEnd byteReadsZeroExtend ifFalse:
		[cogit MoveCq: 0 R: destReg].
	cogit MoveMb: 7 r: sourceReg R: destReg.
	^0