image save/restore
wordSwapped: w
	"Return the given 64-bit integer with its halves in the reverse order."

	objectMemory wordSize = 8 ifFalse: [self error: 'This cannot happen.'].
	^   ((w >> 32) bitAnd: 16r00000000FFFFFFFF) bitOr:
	     ((w << 32) bitAnd: 16rFFFFFFFF00000000)
