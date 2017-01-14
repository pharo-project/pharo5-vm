header format
compiledMethodFormatForNumBytes: numBytes
	^self firstCompiledMethodFormat + (8 - numBytes bitAnd: self wordSize - 1)