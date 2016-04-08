util
highBitOfLargeInt: anOop 
	<inline: true>
	^ self
		cDigitHighBit: (self firstIndexableField: anOop as: #'unsigned int *')
		len: (self digitSizeOfLargeInt: anOop)