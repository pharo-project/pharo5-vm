header format
byteFormatForNumBytes: numBytes
	^self firstByteFormat + (8 - numBytes bitAnd: self wordSize - 1)