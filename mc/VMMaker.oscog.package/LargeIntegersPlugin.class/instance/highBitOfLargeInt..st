util
highBitOfLargeInt: aBytesOop 
	^ self cDigitHighBit: (interpreterProxy firstIndexableField: aBytesOop)
		len: (self digitSizeOfLargeInt: aBytesOop)