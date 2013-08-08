accessing
byteAt: index put: datum

	| loc offset val |
	(datum > 255 or: [datum<0]) ifTrue: [^self error: 'not a byte quantity'].
	loc := ((index-1) // 4) + 1.
	offset := 24 - (8*((index-1) \\ 4)).
	val := ((16rFF << offset) bitInvert32) bitAnd: (self at: loc).
	val := val bitOr: (datum<<offset).
	^super at: loc put: val