compiled methods
firstBytecodeOfAlternateHeader: methodHeader method: theMethod
	^theMethod
	 + ((LiteralStart + (self literalCountOfAlternateHeader: methodHeader)) * objectMemory bytesPerOop)
	 + objectMemory baseHeaderSize