ARM convenience instructions
b: offset
"return a B offset instruction; offset is signed 24bits of WORD offset, so +_32Mbyte range
	B offset"
	^self cond: AL br: 0 offset: offset
