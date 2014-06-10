image save/restore
wordSwapped: w
	"Return the given 64-bit integer with its halves in the reverse order."

	BytesPerWord = 8 ifFalse: [self error: 'This cannot happen.'].
	^   ((w bitShift: Byte4ShiftNegated) bitAnd: Bytes3to0Mask)
	  + ((w bitShift: Byte4Shift         ) bitAnd: Bytes7to4Mask)
