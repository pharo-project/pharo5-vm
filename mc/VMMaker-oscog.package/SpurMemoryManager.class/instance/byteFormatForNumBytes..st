header format
byteFormatForNumBytes: numBytes
	^self firstByteFormat + (numBytes bitAnd: self wordSize - 1)