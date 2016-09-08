ARM convenience instructions
b: offset
"return a B offset instruction; offset is signed 24bits of WORD offset, so +_32Mbyte range
	B offset - ARM_ARM v7 DDI10406 pp. A8-44-5"
	^self cond: AL br: 0 offset: offset
