header access
byteFormatForNumBytes: numBytes
	^self firstByteFormat + (4 - numBytes bitAnd: 3)