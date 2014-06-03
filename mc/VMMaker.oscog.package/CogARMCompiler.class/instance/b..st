ARM convenience instructions
b: offset
"return a B offset instruction"
	^self cond: AL br: 0 offset: offset
