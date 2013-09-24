header access
byteFormatForNumBytes: numBytes
	^self firstByteFormat + (numBytes bitAnd: 3)