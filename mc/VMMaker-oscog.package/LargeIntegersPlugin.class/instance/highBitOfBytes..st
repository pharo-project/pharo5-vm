util
highBitOfBytes: aBytesOop 
	^ self cBytesHighBit: (interpreterProxy firstIndexableField: aBytesOop)
		len: (self byteSizeOfBytes: aBytesOop)