util
highBitOfLargeInt: anOop 
	<inline: true>
	^ self
		cDigitHighBit: (self pointerToFirstDigitOfLargeInt: anOop)
		len: (self digitSizeOfLargeInt: anOop)