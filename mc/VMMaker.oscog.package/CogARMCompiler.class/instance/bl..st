ARM convenience instructions
bl: offset
"return a BL offset instruction; offset is signed 24bits of WORD offset, so +_32Mbyte range. Return address is in LR
	BL offset"
	^self cond: AL br: 1 offset: offset
