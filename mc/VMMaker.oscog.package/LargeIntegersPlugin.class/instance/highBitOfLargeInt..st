util
highBitOfLargeInt: anOop 
	<inline: true>
	^ self
		cDigitHighBit: (interpreterProxy firstIndexableField: anOop)
		len: (self digitSizeOfLargeInt: anOop)